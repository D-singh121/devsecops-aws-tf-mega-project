# vpc and network variables
env                        = "dev"
aws_region                 = "us-east-1"
vpc-cidr-block             = "10.0.0.0/16"
vpc-name                   = "vpc"
igw-name                   = "igw"
public-subnet-count        = 2
public-subnet-name         = "public-subnet"
public-subnet-cidr         = ["10.0.1.0/24", "10.0.2.0/24"]
public-availability-zones  = ["us-east-1a", "us-east-1b"]
private-subnet-count       = 2
private-subnet-name        = "private-subnet"
private-subnet-cidr        = ["10.0.4.0/24", "10.0.5.0/24"]
private-availability-zones = ["us-east-1a", "us-east-1b"]
public-rt-name             = "public-rt"
private-rt-name            = "private-rt"
eip-name                   = "eip"
nat-gw-name                = "nat-gw"
eks-cluster-sg-name        = "eks-cluster-sg"


# eks variables
is_eks_cluster_enabled     = true
cluster_version            = "1.35"
cluster_name               = "gitops-cluster"
endpoint_private_access    = true
endpoint_public_access     = false
ondemand_instance_types    = ["m7i-flex.large"]
desired_capacity_on_demand = 2
min_capacity_on_demand     = 1
max_capacity_on_demand     = 5

addons = [
  {
    name    = "vpc-cni"
    version = "v1.21.1-eksbuild.8"
  },
  {
    name    = "coredns"
    version = "v1.14.2-eksbuild.4"
  },
  {
    name    = "kube-proxy"
    version = "v1.35.3-eksbuild.5"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.59.0-eksbuild.1"
  }
]

# ami_release_version   = "1.34.0-20250704"
# remote_network_cidr   = "10.52.0.0/16"
# remote_pod_cidr       = "10.53.0.0/16"
# eks-node-sg-name      = "eks-node-sg"
# eks-cluster-role-name = "eks-cluster-role"
# eks-node-role-name    = "eks-node-role"


