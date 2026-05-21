output "oidc-arn" {
  description = "ARN of the EKS OIDC provider"
  value       = aws_iam_openid_connect_provider.eks_oidc.arn
}

output "oidc-url" {
  description = "URL (without https://) of the EKS OIDC provider"
  value       = replace(aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")
}

output "cluster-name" {
  description = "Name of the EKS cluster"
  value       = var.is_eks_cluster_enabled ? aws_eks_cluster.eks-cluster[0].name : ""
}

output "cluster-endpoint" {
  description = "API server endpoint of the EKS cluster"
  value       = var.is_eks_cluster_enabled ? aws_eks_cluster.eks-cluster[0].endpoint : ""
}

output "cluster-ca-certificate" {
  description = "Base64-encoded CA certificate of the EKS cluster"
  value       = var.is_eks_cluster_enabled ? aws_eks_cluster.eks-cluster[0].certificate_authority[0].data : ""
}

output "vpc_id" {
  description = "ID of the VPC created for the cluster"
  value       = aws_vpc.cluster-vpc.id
}
