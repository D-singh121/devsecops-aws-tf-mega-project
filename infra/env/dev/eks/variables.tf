variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-workshop"
}
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.34"
}

variable "ami_release_version" {
  description = "Default EKS AMI release version for node groups"
  type        = string
  default     = "1.34.0-20250704"
}

variable "vpc-cidr-block" {
  description = "Defines the CIDR block used on Amazon VPC created for Amazon EKS."
  type        = string
  default     = "10.42.0.0/16"
}

variable "remote_network_cidr" {
  description = "Defines the remote CIDR blocks used on Amazon VPC created for Amazon EKS Hybrid Nodes."
  type        = string
  default     = "10.52.0.0/16"
}

variable "remote_pod_cidr" {
  description = "Defines the remote CIDR blocks used on Amazon VPC created for Amazon EKS Hybrid Nodes."
  type        = string
  default     = "10.53.0.0/16"
}

variable "vpc-name" {
  description = "Name of the VPC"
  type        = string
  default     = "vpc"
}

variable "igw-name" {
  description = "Internet Gateway name"
  type        = string
  default     = "igw"
}

variable "nat-gw-name" {
  description = "NAT Gateway name"
  type        = string
  default     = "nat-gw"
}

variable "public-subnet-count" {
  description = "Number of public subnets"
  type        = number
  default     = 3
}

variable "private-subnet-count" {
  description = "Number of private subnets"
  type        = number
  default     = 3
}

variable "public-subnet-cidr" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.42.1.0/24", "10.42.2.0/24", "10.42.3.0/24"]
}

variable "private-subnet-cidr" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.42.4.0/24", "10.42.5.0/24", "10.42.6.0/24"]
}

variable "public-availability-zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "private-availability-zones" {
  description = "List of availability zones for private subnets"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public-subnet-name" {
  description = "Name prefix for public subnets"
  type        = string
  default     = "public-subnet"
}

variable "private-subnet-name" {
  description = "Name prefix for private subnets"
  type        = string
  default     = "private-subnet"
}

variable "public-rt-name" {
  description = "Public route table name"
  type        = string
  default     = "public-rt"
}

variable "private-rt-name" {
  description = "Private route table name"
  type        = string
  default     = "private-rt"
}

variable "eip-name" {
  description = "Elastic IP name"
  type        = string
  default     = "eip"
}

variable "eks-cluster-sg-name" {
  description = "EKS cluster security group name"
  type        = string
  default     = "eks-cluster-sg"
}

variable "ondemand_instance_types" {
  description = "List of instance types associated with the on-demand EKS Node Group"
  type        = list(string)
  default     = ["t3.medium"]
}


variable "desired_capacity_on_demand" {
  description = "Desired number of on-demand worker nodes"
  type        = number
  default     = 2
}

variable "min_capacity_on_demand" {
  description = "Minimum number of on-demand worker nodes"
  type        = number
  default     = 1
}

variable "max_capacity_on_demand" {
  description = "Maximum number of on-demand worker nodes"
  type        = number
  default     = 5
}

variable "is_eks_cluster_enabled" {
  description = "Whether to create the EKS cluster"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "eks-node-sg-name" {
  description = "EKS node security group name"
  type        = string
  default     = "eks-node-sg"
}

variable "eks-cluster-role-name" {
  description = "EKS cluster IAM role name"
  type        = string
  default     = "eks-cluster-role"
}

variable "eks-node-role-name" {
  description = "EKS node IAM role name"
  type        = string
  default     = "eks-node-role"
}

variable "addons" {
  description = "EKS addons map for for_each (if needed)"
  type        = any
  default     = {}
}
