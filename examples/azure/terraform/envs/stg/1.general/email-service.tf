###################
# Azure Communication Services email
###################
module "aes" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/aes?ref=terraform-azure-aes_v0.0.2"

  #basic
  env                 = var.env
  project             = var.project
  resource_group_name = module.resource_group.resource_group_name

  #communication_service
  communication_service = {
    name          = "wine"
    data_location = "Japan"
  }

  #email
  email_communication_service = {
    name          = "wine"
    data_location = "Japan"
  }

  #domain
  email_communication_service_domain = [
    {
      name                              = "AzureManagedDomain"
      domain_management                 = "AzureManaged"
      association_communication_service = true
    },
    {
      name                              = var.domain
      domain_management                 = "CustomerManaged"
      association_communication_service = true
      verify_domain_name                = var.domain
    }
  ]

  tags = local.default_tags
}
