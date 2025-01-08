###################
# Create storage for Frontend
###################
module "storage_web" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/storage?ref=terraform-azure-storage_v0.0.1"

  #basic
  location            = var.location
  resource_group_name = data.terraform_remote_state.general.outputs.resource_group_name

  #storage
  storage_account = {
    name                     = var.web.content.name
    account_replication_type = var.web.content.blob.account_replication_type
    account_tier             = var.web.content.blob.account_tier
    #static_web
    static_website = {
      index_document     = "index.html"
      error_404_document = "404.html"
    }
    #network_rule
    network_rules = {
      default_action             = "Deny"
      bypass                     = ["AzureServices"]
      ip_rules                   = [for ip in var.global_ips.sun_hni_office : replace(ip, "/32", "")]
      virtual_network_subnet_ids = [data.terraform_remote_state.general.outputs.subnet_web_id]
    }
  }

  #blob
  storage_blob = [
    {
      name                   = "index.html"
      storage_container_name = "$web"
      type                   = "Block"
      source                 = "${path.module}/index.html"
      content_type           = "text/html"
    }
  ]

  tags = local.default_tags
}
