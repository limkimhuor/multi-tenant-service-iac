# 2.web

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_web"></a> [storage\_web](#module\_storage\_web) | git@github.com:framgia/sun-infra-iac.git//modules/storage | terraform-azure-storage_v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.116.0/docs/data-sources/client_config) | data source |
| [terraform_remote_state.general](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain of environment | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of project environment | `string` | n/a | yes |
| <a name="input_full_env"></a> [full\_env](#input\_full\_env) | Full name of project environment | `string` | n/a | yes |
| <a name="input_global_ips"></a> [global\_ips](#input\_global\_ips) | Whitelist ip identify | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Name region of environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of project | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID of subscription | `string` | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | CIDR for vnet | `any` | n/a | yes |
| <a name="input_web"></a> [web](#input\_web) | Storage for app | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_account_info"></a> [azure\_account\_info](#output\_azure\_account\_info) | Show information about project, environment, and account |
| <a name="output_web_url"></a> [web\_url](#output\_web\_url) | URL of web |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
