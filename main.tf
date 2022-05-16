resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

# https://artifacthub.io/packages/helm/cert-manager/cert-manager
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert-manager-version
  namespace  = kubernetes_namespace.cert-manager.metadata.0.name

  set {
    name  = "installCRDs"
    value = "true"
  }

  dynamic "set" {
  for_each = var.set-list
    content {
      name = lookup(set.value, "name", null)
      value = lookup(set.value, "value", null)
      type = lookup(set.value, "type", null)
    }
  }

  values = var.values

}

locals {
  clusterIssuers = <<EOT
clusterIssuers:
${var.cluster-issuers-yaml}
EOT
  issuers        = <<EOT
issuers:
${var.issuers-yaml}
EOT
}

# https://artifacthub.io/packages/helm/adfinis/cert-manager-issuers
resource "helm_release" "cert-manager-issuers" {
  chart      = "cert-manager-issuers"
  name       = "cert-manager-issuers"
  version    = var.cert-manager-issuers-version
  repository = "https://charts.adfinis.com"

  values = [
    var.cluster-issuers-yaml == "" ? "" : local.clusterIssuers,
    var.issuers-yaml == "" ? "" : local.issuers
  ]
}
