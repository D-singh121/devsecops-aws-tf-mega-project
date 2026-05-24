resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "85.2.0"
  namespace        = "prometheus"
  create_namespace = true

  timeout = 3000

  set = [
    {
      name  = "podSecurityPolicies.enabled"
      value = "false"
    },
    {
      name  = "prometheus.service.type"
      value = "LoadBalancer"
    },
    {
      name  = "prometheus.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "external"
    },
    {
      name  = "prometheus.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
      value = "internet-facing"
    },
    {
      name  = "server.persistentVolume.enabled"
      value = "true"
    },
    {
      name  = "server.persistentVolume.storageClassName"
      value = "standard"
    },
    {
      name  = "server.persistentVolume.size"
      value = "10Gi"
    }
  ]

  depends_on = [
    helm_release.argocd
  ]
}

