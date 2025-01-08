# with Terraform

## Install

Refer how to install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) base on your OS.

## How to use

### Initialization

#### I. Create environments & services

- Create environment folders and services folders in environment. Examples:
  - [ ] DEV
  - [x] STG
  - [x] PRD

- Symlink variables.tf file of environment to each service folder of it and add this symlink file to gitignore with two method

  *1. Symlink specific service*

  - Excute `make symlink e=<environment-name> s=<service-name>`. Example:

    ```bash
    make symlink e=stg s=general
    ```

  *2. Symlink all services*

  - Excute `make symlink_all e=<environment-name>`. Example:

    ```bash
    make symlink_all e=stg
    ```

  *3. Unsymlink specific service*

  - Excute `make unsymlink e=<environment-name> s=<service-name>`. Example:

    ```bash
    make unsymlink e=stg s=general
    ```

  *4. Unsymlink all services*

  - Excute `make unsymlink_all e=<environment-name>`. Example:

    ```bash
    make unsymlink_all e=stg
    ```

#### [II. Terraform init](https://www.terraform.io/cli/commands/init)

*1. Init specific service*

- Excute `make init e=<environment-name> s=<service-name>`. Example:

    ```bash
    make init e=stg s=general
    ```

*2. Init upgrade for service*

- Excute `make init_upgrade e=<environment-name> s=<service-name>`. Example:

    ```bash
    make init_upgrade e=stg s=general
    ```

*3. Init migrate state for service*

- Excute `make init_migrate e=<environment-name> s=<service-name>`. Example:

    ```bash
    make init_migrate e=stg s=general
    ```

*4. Init all services*

- Excute `make init_all e=<environment-name>`. Example:

    ```bash
    make init_all e=stg
    ```

### Deployment

#### [I. Terraform plan](https://www.terraform.io/cli/commands/plan)

*1. Plan specific service*

- Excute `make plan e=<environment-name> s=<service-name>` (If you want to plan before destroy, excute `make plan_destroy e=<environment-name> s=<service-name>` instead). Example:

    ```bash
    make plan e=stg s=general
    ```

*2. Plan specific service with module target*

- Excute `make plan_target e=<environment-name> s=<service-name> t='<module-name>'` (If you want to plan before destroy target, excute `make plan_destroy_target e=<environment-name> s=<service-name> t='<module-name>'` instead). Example:

    ```bash
    make plan_target e=stg s=general t=module.vnet
    ```

*3. Plan all services*

- Excute `make plan_all e=<environment-name>`(If you want to plan before destroy all, excute `make plan_destroy_all e=<environment-name>` instead). Example:

    ```bash
    make plan_all e=stg
    ```

#### [II. Terraform apply](https://www.terraform.io/cli/commands/apply)

*1. Apply specific service*

- Excute `make apply e=<environment-name> s=<service-name>`. Example:

    ```bash
    make apply e=stg s=general
    ```

*2. Apply specific service with module target*

- Excute `make apply_target e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make apply_target e=stg s=general t=module.vnet
    ```

*3. Apply all services*

- Excute `make apply_all e=<environment-name>`. Example:

    ```bash
    make apply_all e=stg
    ```

#### [III. Terraform destroy](https://www.terraform.io/cli/commands/apply)

*1. Destroy specific service*

- Excute `make destroy e=<environment-name> s=<service-name>`. Example:

    ```bash
    make destroy e=stg s=general
    ```

*2. Destroy specific service with module target*

- Excute `make destroy_target e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make destroy_target e=stg s=general t=module.vnet
    ```

*3. Destroy all services*

- Excute `make destroy_all e=<environment-name>`. Example:

    ```bash
    make destroy_all e=stg
    ```

#### IV. Other Terraform commands

*1. Recreate a resource in service*

- Excute `make taint e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make taint e=stg s=general t='module.app_fe.azuread_application_federated_identity_credential.application_federated_identity_credential["github"]'
    ```

*2. **Do not** recreate a resource in service*

- Excute `make untaint e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make untaint e=stg s=general t='module.app_fe.azuread_application_federated_identity_credential.application_federated_identity_credential["github"]'
    ```

*3. List all state of service*

- Excute `make state_list e=<environment-name> s=<service-name>`. Example:

    ```bash
    make state_list e=stg s=general
    ```

*4. Show state of resource in service*

- Excute `make state_show e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make state_show e=stg s=general t='module.app_fe.azuread_application.application'
    ```

*5. Import state of resource into service*

- Excute `make state_import e=<environment-name> s=<service-name> t='<module-name>' ot='<other-module-name>'`. Example:

    ```bash
    make state_import e=stg s=general t=module.resource_group.azurerm_resource_group.resource_group ot=/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/project-stg-rg
    make state_import e=stg s=general t=module.dns_zone.azurerm_dns_zone.dns_zone[0] ot=/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/project-stg-rg/providers/Microsoft.Network/dnsZones/vaan.eragon123app.com
    ```

*6. Remove state of resource out of service*

- Excute `make state_rm e=<environment-name> s=<service-name> t='<module-name>'`. Example:

    ```bash
    make state_rm e=stg s=general t='module.app_fe.azuread_application.application'
    ```

*7. Move state of resource to another state in service*

- Excute `make state_mv e=<environment-name> s=<service-name> t='<module-name>' ot='<other-module-name>'`. Example:

    ```bash
    make state_mv e=stg s=general t='module.app_fe.azuread_application_federated_identity_credential.application_federated_identity_credential["github"]' ot='module.app_fe.azuread_application_federated_identity_credential.application_federated_identity_credential["new-github"]'
    ```

## Structure

### Example

```
├── terraform
│   ├── envs
│   │   ├── dev
│   │   └── stg
│   │   └── prd
│   └── README.md
└── terraform-dependencies
    └── github
        └── workflows
            └── deploy-container-app.yml
```

### Vars

- Create variables for main
  - [x] variables.tf
- Values of variables for each environment
  - [ ] terraform.dev.tfvars
  - [ ] terraform.stg.tfvars
  - [ ] terraform.prd.tfvars

### Main

- Using **Modules** method
  - containers for multiple resources that are used together
  - the main way to package and reuse resource configurations with Terraform.
- [**Module Blocks**](https://www.terraform.io/language/modules/syntax#module-blocks)
- [**Module Sources from Github**](https://www.terraform.io/language/modules/sources#github) are tagged and released here <https://github.com/framgia/sun-infra-iac/tags>

Example:

```terraform
  module "example" {
    source = "git@github.com:framgia/sun-infra-iac.git//modules/vnet?ref=terraform-azure-vnet_v0.0.2"
  }
```

### Backend

- Backends primarily determine where Terraform stores its state. Terraform uses this persisted state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.

### Outputs

- Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

## Naming & Coding Conventions

1. Name of the service and `Name` tag you will create following format

   ```
   Name = "${var.project}--${var.env}-${var.name}-<aws/azure/gcp-service-name>"
   ```

Besides `${var.name}`, you can use `${var.type}`, `${var.region}`...depends on how many resources in a module or the way you create it.

2. `Resource and data source arguments`

- The name of a resource should be more descriptive. Examples:

  ```terraform
  resource "azurerm_subnet" "subnet" {}
  resource "azurerm_route_table" "route_table" {}
  ```

- If not, the name of a resource can be the same as the resource name that the provider defined. Examples:

  ```terraform
  resource "azurerm_virtual_network" "virtual_network" {}
  ```

- Notes:
  - Always use singular nouns for names.
  - Use _ (underscore) instead of - (dash) everywhere (in resource names, data source names, variable names, outputs, etc).
  - Prefer to use lowercase letters and numbers (even though UTF-8 is supported)

3. Usage of `count`/`for_each`

- Include argument `count`/`for_each` inside resource or data source block as the first argument at the top and separate by newline after it. Example:

  ```terraform
  resource "azurerm_route_table" "route_table" {
    for_each = var.route_tables != null ? { for route_table in var.route_tables : route_table.name => route_table } : {}
    # ... remaining arguments omitted
  }
  ```

- When using conditions in an argument `count`/`for_each` prefer boolean values instead of using `length` or other expressions.

4. Placement of `tags`

- Include argument `tags`, if supported by resource, as the last real argument, following by depends_on and lifecycle, if necessary. All of these should be separated by a single empty line.
- Use `merge` to combine `name_tag` and `tags` in `default_tags` within the locals function in the `_locals.tf` file.

    ```terraform
    resource "azurerm_container_registry" "acr" {
      resource_group_name = var.resource_group_name
      location            = var.location

      name          = var.acr.name
      sku           = var.acr.sku
      admin_enabled = var.acr.admin_enabled

      dynamic "retention_policy" {
        for_each = var.acr.retention_policy != null ? [var.acr.retention_policy] : []
        content {
          enabled = retention_policy.value.enabled
          days    = retention_policy.value.days
        }
      }

      dynamic "identity" {
        for_each = var.acr.identity != null ? [var.acr.identity] : []
        content {
          type         = identity.value.type
          identity_ids = identity.value.identity_ids
        }
      }

      dynamic "encryption" {
        for_each = var.acr.encryption != null ? [var.acr.encryption] : []
        content {
          key_vault_key_id   = encryption.value.key_vault_key_id
          identity_client_id = encryption.value.identity_client_id
        }
      }

      tags = merge(
        var.tags,
        {
          Name = var.acr.name
        }
      )
    }
    ```

<!-- - Do not add `Project` & `Environment` tags in resources because we add it by default tag at `provider` function in `backend.tf` file. -->

5. Variables

- Use the plural form in a variable name when type is list(...) or map(...).
- Order keys in a variable block like this: description , default, type, validation.
- Always include description on all variables even if you think it is obvious (**Prefer write it from [Terraform docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)**).

6. Outputs

- Good structure for the name of output looks like {name}_{attribute} , where:
  - {name} is a name of resource or data source.
  - {attribute} is an attribute returned by the output.
- If the returned value is a list it should have a plural name. See example.
- Always include description for all outputs even if you think it is obvious.
- Example: `resource "azurerm_mssql_server" "mssql_server" {}` ->

    ```terraform
    output "mssql_server_id" {
      value       = azurerm_mssql_server.mssql_server.id
      description = "The Microsoft SQL Server ID."
    }
    ```

7. `Modules`

- Resources:
  - In the module, if you have 2 or more resources:
    - The name of the variable will have a prefix of the name of the resource.
    - Each resource will create a variable and each attribute of the resource will use its child variables (There will be some exceptions).
    - If you meet a block attribute, create one variable and use also its child variables for the attributes inside it.
    - Example:

      ```terraform
      resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
        name                                                   = "${var.project}-${var.env}-${var.virtual_machine.name}-vm"
        resource_group_name                                    = var.resource_group_name
        location                                               = var.location
        size                                                   = var.virtual_machine.size
        network_interface_ids                                  = length(var.virtual_machine.network_interface_ids) > 0 ? var.virtual_machine.network_interface_ids : flatten([for nic in values(azurerm_network_interface.network_interface) : nic.id])
        admin_username                                         = var.virtual_machine.admin_username
        license_type                                           = var.virtual_machine.license_type
        admin_password                                         = var.virtual_machine.admin_password

        ...
      }

      # For API Gateway
      resource "azurerm_public_ip" "vm_public_ip" {
        for_each = {
            for nic in var.network_interfaces : nic.name => nic
            if length([for ip_conf in nic.ip_configurations : ip_conf.public_ip_address_enable if ip_conf.public_ip_address_enable == true]) > 0
        }

        name                = "${var.project}-${var.env}-${each.key}-eip"
        resource_group_name = var.resource_group_name
        location            = var.location
        allocation_method   = "Static"

        tags = merge(
          var.tags,
          {
            name = "${var.project}-${var.env}-${each.key}-eip"
          }
        )
      }
      ```

  - In the module, if you have one resource:
    - The name of the variable will be the same as the attribute of the resource
    - Each attribute will create a variable. (There will be some exceptions).
    - If you meet a block attribute, create one variable and use also its child variables for the attributes inside it.
    - Example:

      ```terraform
      resource "azurerm_resource_group" "resource_group" {
        name     = "${var.project}-${var.env}-rg"
        location = var.location

        tags = merge(
          var.tags,
          {
            name = "${var.project}-${var.env}-rg"
          }
        )
      }
      ```

- Variables:
  - In the module, if you use `project`, `env`, `region` variables... Put it first in #basic block, for another variables of resources give them another block and separate by newline after
  - Example:

    ```terraform
    #modules/acr/_variables.tf
    #basic
    variable "project" {
      description = "Name of project"
      type        = string
    }
    variable "env" {
      description = "Name of project environment"
      type        = string
    }
      variable "location" {
      description = "Location of environment"
    type        = string
    }
    variable "resource_group_name" {
      description = "Name of resource group"
      type        = string
    }

    #tag
    variable "tags" {
      description = "(Optional) Common tags"
      type        = map(string)
      default     = null
    }

    #acr
    variable "acr" {
      description = "All configuration to Provides an Azure Container Registry Repository."
      type = object({
        name          = string
        sku           = optional(string, "Basic")
        admin_enabled = optional(bool, false)
        retention_policy = optional(object({
        enabled = optional(bool, false)
        days    = optional(number, 7)
        }), null)
        identity = optional(object({
        type         = string
        identity_ids = optional(list(string), [])
        }), null)
        encryption = optional(object({
        key_vault_key_id   = string
        identity_client_id = string
        }), null)
      })
    }
    ```

- Outputs:
  - Separated by blocks by function or resource created
  - Example:

    ```terraform
    #modules/vnet/_outputs.tf
    #vnet
    output "vnet_id" {
      value       = azurerm_virtual_network.virtual_network.id
      description = "ID of vnet"
    }
    output "vnet_name" {
      value       = azurerm_virtual_network.virtual_network.name
      description = "Name of vnet"
    }

    #subnet
    output "subnet_id" {
      value       = { for key, value in azurerm_subnet.subnet : key => value.id }
      description = "ID of subnet"
    }
    output "subnet_name" {
      value       = { for key, value in azurerm_subnet.subnet : key => value.name }
      description = "Name of subnet"
    }

    #route-table
    output "route_table_id" {
      value       = { for key, value in azurerm_route_table.route_table : key => value.name }
      description = "The Route Table ID."
    }
    ```

### Create new modules

- Check out to base branch `terraform-<cloud-platform>-base` (Example: `terraform-azure-base`). Remember fetch latest & pull to your local branch.
- Create new branch like `terraform-azure-<terraform-module>` (Example: `terraform-azure-vnet`) from `terraform-azure-base` branch. Example:

  ```
  git checkout terraform-azure-base
  git checkout -b terraform-azure-vnet
  git push origin terraform-azure-vnet
  ```

- **Note:** Describe your module in README.md at root folder.
