variable "cert-manager-version" {
  type        = string
  default     = "v1.5.4"
  description = "Version of the Cert-Manager helm chart to use"
}

variable "cert-manager-issuers-version" {
  type        = string
  default     = "0.2.2"
  description = "Version of the Cert-Manager-issuers helm chart to use"
}

variable "issuers-yaml" {
  type        = string
  default     = ""
  description = "The YAML code to define issuers for cert-manager. Example: https://github.com/adfinis-sygroup/helm-charts/blob/master/charts/cert-manager-issuers/examples/disable-issuers.yaml"
}

variable "cluster-issuers-yaml" {
  type        = string
  default     = ""
  description = "The YAML code to define cluster issuers for cert-manager. Example: https://github.com/adfinis-sygroup/helm-charts/blob/master/charts/cert-manager-issuers/examples/letsencrypt-clusterissuers.yaml"
}

variable "set-list" {
  type = list(object({
    name = string,
    value = string,
    type = string,
  }))
  default = []
  description = "A list of settings to apply to on the helm chart using its parameter 'set { }' "
}

variable "values" {
  type = list(string)
  default = []
  description = "A list of values to apply on the helm chart using its parameter 'values = [...]' "
}
