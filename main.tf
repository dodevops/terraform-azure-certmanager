resource "kubernetes_namespace_v1" "cert-manager" {
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
  namespace  = kubernetes_namespace_v1.cert-manager.metadata.0.name

  set = concat(
    [
      {
        name  = "installCRDs"
        value = true
      }
    ],
    [
      for s in var.set-list : {
        name  = lookup(s, "name", null)
        value = lookup(s, "value", null)
        type  = lookup(s, "type", null)
      }
      if lookup(s, "name", null) != null && lookup(s, "value", null) != null
    ]
  )

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
