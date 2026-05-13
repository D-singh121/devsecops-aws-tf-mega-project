resource "aws_eks_cluster" "eks-cluster" {
  count    = var.is_eks_cluster_enabled ? 1 : 0
  name     = var.cluster-name
  role_arn = aws_iam_role.eks_cluster_role[count.index].arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = aws_subnet.private-subnet[*].id
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = [aws_security_group.eks-cluster-sg.id]
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    Name        = var.cluster-name
    environment = var.environment
  }

  depends_on = [
    aws_iam_role.eks_cluster_role
  ]
}

#oidc provider
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-certificate.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks-certificate.url
}

# add-ons
resource "aws_eks_addon" "eks-addons" {
  for_each      = { for addon in var.addons : addon.name => addon }
  cluster_name  = aws_eks_cluster.eks-cluster[0].name
  addon_name    = each.value.name
  addon_version = each.value.version

  service_account_role_arn = each.value.name == "aws-ebs-csi-driver" ? aws_iam_role.ebs_csi_role.arn : null

  depends_on = [
    aws_eks_node_group.ondemand-node,
    # aws_eks_node_group.spot-node
  ]
}

resource "aws_eks_node_group" "ondemand-node" {
  count           = var.is_eks_cluster_enabled ? 1 : 0
  cluster_name    = aws_eks_cluster.eks-cluster[count.index].name
  node_group_name = "${var.cluster-name}-ondemand-nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role[count.index].arn
  subnet_ids      = aws_subnet.private-subnet[*].id

  scaling_config {
    desired_size = var.desired_capacity_on_demand
    max_size     = var.max_capacity_on_demand
    min_size     = var.min_capacity_on_demand
  }

  instance_types = var.ondemand_instance_types
  capacity_type  = "ON_DEMAND"
  labels = {
    type = "ondemand"
  }

  update_config {
    max_unavailable = 1

  }

  tags = {
    Name        = "${var.cluster-name}-ondemand-nodes"
    environment = var.environment
  }

  tags_all = {
    Name                                        = "${var.cluster-name}-ondemand-nodes"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }

  depends_on = [
    aws_eks_cluster.eks-cluster,
  ]
}




