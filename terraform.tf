# setting required because we need helm >= 3.3, see https://cert-manager.io/docs/installation/helm/#option-2-install-crds-as-part-of-the-helm-release
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.3.1"
    }
  }
}