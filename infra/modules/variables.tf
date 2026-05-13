variable "cluster-name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "is_eks_role_enabled" {
  description = "Whether to create EKS cluster role"
  type        = bool
  default     = true
}

variable "is_eks_nodegroup_role_enabled" {
  description = "Whether to create EKS node group role"
  type        = bool
  default     = true
}

variable "is_eks_cluster_enabled" {
  description = "Whether to create the EKS cluster"
  type        = bool
  default     = true
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
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

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "desired_capacity_on_demand" {
  description = "Desired number of on-demand worker nodes"
  type        = number
}

variable "max_capacity_on_demand" {
  description = "Maximum number of on-demand worker nodes"
  type        = number
}

variable "min_capacity_on_demand" {
  description = "Minimum number of on-demand worker nodes"
  type        = number
}

variable "ondemand_instance_types" {
  description = "List of instance types associated with the on-demand EKS Node Group"
  type        = list(string)
}

variable "vpc-cidr-block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc-name" {
  description = "Name of the VPC"
  type        = string
}

variable "igw-name" {
  description = "Internet Gateway name"
  type        = string
}

variable "eip-name" {
  description = "Elastic IP name"
  type        = string
}

variable "nat-gw-name" {
  description = "NAT Gateway name"
  type        = string
}

variable "private-subnet-count" {
  description = "Number of private subnets"
  type        = number
}

variable "private-subnet-cidr" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "private-availability-zones" {
  description = "List of availability zones for private subnets"
  type        = list(string)
}

variable "private-subnet-name" {
  description = "Name prefix for private subnets"
  type        = string
}

variable "public-subnet-count" {
  description = "Number of public subnets"
  type        = number
}

variable "public-subnet-cidr" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "public-availability-zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

variable "public-subnet-name" {
  description = "Name prefix for public subnets"
  type        = string
}

variable "public-rt-name" {
  description = "Public route table name"
  type        = string
}

variable "private-rt-name" {
  description = "Private route table name"
  type        = string
}

variable "eks-cluster-sg-name" {
  description = "EKS cluster security group name"
  type        = string
}

variable "addons" {
  description = "EKS addons map for for_each (if needed)"
  type        = any
  default     = {}
}

variable "eks-node-sg-name" {
  description = "EKS node security group name"
  type        = string
}

variable "eks-cluster-role-name" {
  description = "EKS cluster IAM role name"
  type        = string
}

variable "eks-node-role-name" {
  description = "EKS node IAM role name"
  type        = string
}

variable "ami_release_version" {
  description = "Default EKS AMI release version for node groups"
  type        = string
}

variable "remote_network_cidr" {
  description = "Defines the remote CIDR blocks used on Amazon VPC created for Amazon EKS Hybrid Nodes."
  type        = string
}

variable "remote_pod_cidr" {
  description = "Defines the remote CIDR blocks used on Amazon VPC created for Amazon EKS Hybrid Nodes."
  type        = string
}
