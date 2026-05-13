locals {
  cluster-name = var.cluster-name
}


resource "aws_vpc" "cluster-vpc" {
  cidr_block           = var.vpc-cidr-block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = var.vpc-name
    environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cluster-vpc.id

  tags = {
    Name                                          = var.igw-name
    environment                                   = var.environment
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
  }

  depends_on = [
    aws_vpc.cluster-vpc
  ]
}

// nat gateway requires elastic ip

resource "aws_eip" "ngw-eip" {
  domain = "vpc"

  tags = {
    Name        = var.eip-name
    environment = var.environment
  }

  depends_on = [
    aws_vpc.cluster-vpc
  ]
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name        = var.nat-gw-name
    environment = var.environment
  }

  depends_on = [
    aws_vpc.cluster-vpc,
    aws_eip.ngw-eip
  ]
}

resource "aws_subnet" "private-subnet" {
  count             = var.private-subnet-count
  vpc_id            = aws_vpc.cluster-vpc.id
  cidr_block        = element(var.private-subnet-cidr, count.index)
  availability_zone = element(var.private-availability-zones, count.index)

  tags = {
    Name                                          = "${var.private-subnet-name}-${count.index}"
    environment                                   = var.environment
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
  }

  depends_on = [
    aws_vpc.cluster-vpc
  ]
}

resource "aws_subnet" "public-subnet" {
  count                   = var.public-subnet-count
  vpc_id                  = aws_vpc.cluster-vpc.id
  cidr_block              = element(var.public-subnet-cidr, count.index)
  availability_zone       = element(var.public-availability-zones, count.index)
  map_public_ip_on_launch = true


  tags = {
    Name                                          = "${var.public-subnet-name}-${count.index + 1}"
    environment                                   = var.environment
    "kubernetes.io/cluster/${local.cluster-name}" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }

  depends_on = [
    aws_vpc.cluster-vpc
  ]
}

resource "aws_route_table" "public-rt-table" {
  vpc_id = aws_vpc.cluster-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = var.public-rt-name
    environment = var.environment
  }

  depends_on = [aws_vpc.cluster-vpc]
}

resource "aws_route_table_association" "public-rt-table-association" {
  count          = var.public-subnet-count
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-rt-table.id

  depends_on = [
    aws_vpc.cluster-vpc,
    aws_subnet.public-subnet,
    aws_route_table.public-rt-table
  ]
}

resource "aws_route_table" "private-rt-table" {
  vpc_id = aws_vpc.cluster-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name        = var.private-rt-name
    environment = var.environment
  }

  depends_on = [aws_vpc.cluster-vpc]
}

resource "aws_route_table_association" "private-rt-table-association" {
  count          = var.private-subnet-count
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt-table.id

  depends_on = [
    aws_vpc.cluster-vpc,
    aws_subnet.private-subnet,
    aws_route_table.private-rt-table
  ]
}


resource "aws_security_group" "eks-cluster-sg" {
  name        = var.eks-cluster-sg-name
  description = "Allow 443 from jump host server only "

  vpc_id = aws_vpc.cluster-vpc.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id] // allowed from jump host server
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = var.eks-cluster-sg-name
    environment = var.environment
  }
}
