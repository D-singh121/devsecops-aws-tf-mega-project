terraform {
  required_version = ">= 1.15.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.1.0"
    }

    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.15.3"
    }
  }
  backend "s3" {
    bucket = "eks-devsecops-deploy-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  region = "us-east-1"
}


data "aws_eks_cluster" "eks_cluster" {
  name       = "${var.env}-${local.org}-${var.cluster_name}"
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name       = "${var.env}-${local.org}-${var.cluster_name}"
  depends_on = [module.eks]
}



provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks_cluster.name]
    command     = "aws"
  }
}


provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks_cluster.name]
      command     = "aws"
    }
  }
}


