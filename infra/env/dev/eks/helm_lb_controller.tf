resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.9.1"
  namespace  = kubernetes_namespace_v1.lb_controller_namespace.metadata[0].name

  set = [
    {
      name  = "clusterName"
      value = "${local.env}-${local.org}-${var.cluster_name}"
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = kubernetes_service_account_v1.lb_controller_service_account.metadata[0].name
    },
    {
      name  = "region"
      value = var.aws_region
    },
    {
      name  = "vpcIds"
      value = module.eks.vpc_id
    }
  ]

  depends_on = [
    kubernetes_service_account_v1.lb_controller_service_account,
    aws_iam_role_policy_attachment.lb_controller_policy_attachment
  ]

}
