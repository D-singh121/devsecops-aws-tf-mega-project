locals {
  org = "Devsecops-org"
  env = var.env
}

module "eks" {
  source = "../../../modules"

  environment     = local.env
  cluster_version = var.cluster_version

  cluster-name                  = "${local.env}-${local.org}-${var.cluster_name}"
  vpc-cidr-block                = var.vpc-cidr-block
  vpc-name                      = "${local.env}-${local.org}-${var.vpc-name}"
  igw-name                      = "${local.env}-${local.org}-${var.igw-name}"
  nat-gw-name                   = "${local.env}-${local.org}-${var.nat-gw-name}"
  public-subnet-count           = var.public-subnet-count
  private-subnet-count          = var.private-subnet-count
  public-subnet-cidr            = var.public-subnet-cidr
  private-subnet-cidr           = var.private-subnet-cidr
  public-availability-zones     = var.public-availability-zones
  private-availability-zones    = var.private-availability-zones
  public-subnet-name            = "${local.env}-${local.org}-${var.public-subnet-name}"
  private-subnet-name           = "${local.env}-${local.org}-${var.private-subnet-name}"
  public-rt-name                = "${local.env}-${local.org}-${var.public-rt-name}"
  private-rt-name               = "${local.env}-${local.org}-${var.private-rt-name}"
  eip-name                      = "${local.env}-${local.org}-${var.eip-name}"
  eks-cluster-sg-name           = var.eks-cluster-sg-name
  is_eks_role_enabled           = true
  is_eks_nodegroup_role_enabled = true
  ondemand_instance_types       = var.ondemand_instance_types
  desired_capacity_on_demand    = var.desired_capacity_on_demand
  min_capacity_on_demand        = var.min_capacity_on_demand
  max_capacity_on_demand        = var.max_capacity_on_demand
  is_eks_cluster_enabled        = var.is_eks_cluster_enabled
  endpoint_private_access       = var.endpoint_private_access
  endpoint_public_access        = var.endpoint_public_access

  eks-node-sg-name      = var.eks-node-sg-name
  eks-cluster-role-name = var.eks-cluster-role-name
  eks-node-role-name    = var.eks-node-role-name
  ami_release_version   = var.ami_release_version
  remote_network_cidr   = var.remote_network_cidr
  remote_pod_cidr       = var.remote_pod_cidr

  addons = var.addons

}


