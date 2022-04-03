###################
# IAM Role for Lambda example with default policy
###################
module "iam_role_lambda_example_admin" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/iam-role?ref=terraform-aws-iam_v0.0.3"
  #basic
  env     = var.env
  project = var.project

  #iam-role
  iam_assume_role_template = "../../../templates/policy/assume-role-lambda.json"
  name                     = "lambda-example-admin"
  service                  = "lambda"
  iam_policy_default_arn = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
