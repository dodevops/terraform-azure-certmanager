# Installs and configures cert-manager

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

# documentation: https://cert-manager.io/docs/installation/helm/
resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.5.4"
  namespace  = kubernetes_namespace.cert-manager.metadata.0.name

  set {
    name = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "cert-manager-clusterissuer" {
  name = "cert-manager-clusterissuer"
  chart = "../helm-charts/cert-manager-cluster-issuer"

  set {
    name = "letsencryptEmail"
    value = var.email
  }

  depends_on = [
    helm_release.cert-manager,
  ]
}

# TODO: to replaced by helm chart
//
//resource "kubernetes_manifest" "cluster-issuer-prod" {
//  manifest = {
//    apiVersion = "cert-manager.io/v1alpha2" # TODO, still correct?
//    kind = "ClusterIssuer"
//    metadata = {
//      name = "letsencrypt-prod"
//    }
//  }
//}
//
//apiVersion: cert-manager.io/v1alpha2
//kind: ClusterIssuer
//metadata:
//    name: letsencrypt-prod
//spec:
//    acme:
//        # The ACME server URL
//        server: https://acme-v02.api.letsencrypt.org/directory
//        # Email address used for ACME registration
//        email: {{ .Values.letsencryptEmail }}
//        # Name of a secret used to store the ACME account private key
//        privateKeySecretRef:
//            name: letsencrypt-prod
//        # Enable the HTTP-01 challenge provider
//        solvers:
//            - http01:
//                  ingress:
//                      class: nginx