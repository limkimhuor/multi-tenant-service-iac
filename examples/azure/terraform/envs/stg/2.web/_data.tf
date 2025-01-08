data "azurerm_client_config" "current" {}

###################
# General State
###################
data "terraform_remote_state" "general" {
  backend = "azurerm"
  config = {
    resource_group_name  = "vannt-rg"
    storage_account_name = "vanntiacstate"
    container_name       = "iacstate"
    key                  = "1.general/terraform.${var.env}.tfstate"
  }
}
