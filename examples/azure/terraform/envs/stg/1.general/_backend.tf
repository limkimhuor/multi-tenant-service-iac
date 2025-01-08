###################
# General Initialization
###################
terraform {
  required_version = ">= 1.3.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.53.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "= 1.13.1"
    }
    template = "~> 2.0"
  }

  backend "azurerm" {
    resource_group_name  = "vannt-rg"
    storage_account_name = "vanntiacstate"
    container_name       = "iacstate"
    key                  = "1.general/terraform.stg.tfstate"
  }
}
