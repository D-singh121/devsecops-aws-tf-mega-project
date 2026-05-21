resource "aws_iam_policy" "lb_controller_policy" {
  name   = "AWSLoadBalancerControllerIAMPolicy"
  policy = file("./iam_policy.json")
}


resource "aws_iam_role" "k8s_lb_controller_role" {
  name = "AWSLoadBalancerControllerRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc-arn
        }
        Condition = {
          StringEquals = {
            "${module.eks.oidc-url}:sub" = "system:serviceaccount:aws-load-balancer-controller-ns:aws-load-balancer-controller-svc"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lb_controller_policy_attachment" {
  policy_arn = aws_iam_policy.lb_controller_policy.arn
  role       = aws_iam_role.k8s_lb_controller_role.name
}

resource "kubernetes_namespace_v1" "lb_controller_namespace" {
  metadata {
    name = "aws-load-balancer-controller-ns"
  }
}

resource "kubernetes_service_account_v1" "lb_controller_service_account" {
  metadata {
    name      = "aws-load-balancer-controller-svc"
    namespace = kubernetes_namespace_v1.lb_controller_namespace.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.k8s_lb_controller_role.arn
    }
  }
  depends_on = [kubernetes_namespace_v1.lb_controller_namespace]
}



