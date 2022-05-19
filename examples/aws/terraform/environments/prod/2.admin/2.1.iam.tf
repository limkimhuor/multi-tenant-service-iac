###################
# IAM Role for Lambda example admin with custom policy
###################
module "iam_role_lambda_example_admin" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/iam-role?ref=terraform-aws-iam_v0.0.4"
  #basic
  env     = var.env
  project = var.project

  #iam-role
  iam_assume_role = {
    template = "../../../templates/policy/assume-role-lambda.json"
  }
  name    = "lambda-example-admin"
  service = "lambda"
  iam_policy = {
    custom_policy = {
      template = "../../../templates/policy/lambda-example-admin.json"
      vars = {
        region = var.region
        vpc_id = data.terraform_remote_state.general.outputs.vpc_id
      }
    }
  }
}
