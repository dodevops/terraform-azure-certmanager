# Terraform management of cert-manager on AKS

## Introduction

This module manages cert-manager on AKS (Azure Kubernetes Service)

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "azure-basics" {
  source  = "dodevops/certmanager/azure"
  version = "<version>"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- helm (>= 2.4.1)

## Providers

The following providers are used by this module:

- helm (>= 2.4.1)

- kubernetes

## Modules

No modules.

## Resources

The following resources are used by this module:

- [helm_release.cert-manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [helm_release.cert-manager-issuers](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) (resource)
- [kubernetes_namespace.cert-manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### cert-manager-issuers-version

Description: Version of the Cert-Manager-issuers helm chart to use

Type: `string`

Default: `"0.2.2"`

### cert-manager-version

Description: Version of the Cert-Manager helm chart to use

Type: `string`

Default: `"v1.5.4"`

### cluster-issuers-yaml

Description: The YAML code to define cluster issuers for cert-manager. Example: https://github.com/adfinis-sygroup/helm-charts/blob/master/charts/cert-manager-issuers/examples/letsencrypt-clusterissuers.yaml

Type: `string`

Default: `""`

### issuers-yaml

Description: The YAML code to define issuers for cert-manager. Example: https://github.com/adfinis-sygroup/helm-charts/blob/master/charts/cert-manager-issuers/examples/disable-issuers.yaml

Type: `string`

Default: `""`

### set-list

Description: A list of additional settings to apply to the helm chart using the terraform `set{}` parameter. Example:
```
  set-list = [
    {
      "name"  = "prometheus.enabled",
      "value" = "false",
      "type"  = "auto"
    },
  ]
```

Type:

```hcl
list(object({
    name  = string,
    value = string,
    type  = string,
  }))
```

Default: `[]`

### values

Description: A list of additional values to apply to the helm chart using the  'values = [...]' parameter. Example:
```
  values = [
    "<yaml>",
  ]
```

Type: `list(string)`

Default: `[]`

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
