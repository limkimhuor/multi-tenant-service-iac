###################
# IAM Role for Lambda example with custom policy
###################
module "iam_role_lambda_example" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/iam-role?ref=terraform-aws-iam_v0.0.1"
  #basic
  env     = var.env
  project = var.project

  #iam-role
  iam_assume_role_template = "${path.module}/iam-policy/assume-role-lambda.json"
  name                     = "lambda-example"
  service                  = "lambda"
  iam_policy_template      = "${path.module}/iam-policy/lambda-example.json"
}
