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
  }

  backend "azurerm" {
    resource_group_name  = "vannt-rg"
    storage_account_name = "vanntiacstate"
    container_name       = "iacstate"
    key                  = "2.web/terraform.prod.tfstate"
  }
}
