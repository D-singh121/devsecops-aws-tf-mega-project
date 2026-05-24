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






provider "kubernetes" {
  host                   = module.eks.cluster-endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster-ca-certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster-name]
    command     = "aws"
  }
}


provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster-endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster-ca-certificate)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster-name]
      command     = "aws"
    }
  }
}


