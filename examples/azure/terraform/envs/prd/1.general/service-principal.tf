###################
# Create service principal with OIDC
###################
module "app_fe" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/service-principal?ref=terraform-azure-service-principal_v0.0.1"

  #basic
  env     = var.env
  project = var.project

  #app
  application = {
    name   = "fe"
    owners = [data.azuread_client_config.current.object_id]
  }

  #federated
  federated_identity = [
    {
      display_name = "github"
      audiences    = ["api://AzureADTokenExchange"]
      issuer       = "https://token.actions.githubusercontent.com"
      subject      = "repo:demo-vannt-3105/demo-github-action:ref:refs/heads/master"
    }
  ]
}
