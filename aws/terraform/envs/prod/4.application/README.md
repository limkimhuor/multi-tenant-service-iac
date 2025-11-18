# 4.application

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.21.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecs_service.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_secretsmanager_secret.app_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.app_secrets_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.secret_key_base](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.compute](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.database](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.general](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_container_port"></a> [app\_container\_port](#input\_app\_container\_port) | n/a | `number` | n/a | yes |
| <a name="input_app_cpu"></a> [app\_cpu](#input\_app\_cpu) | n/a | `number` | n/a | yes |
| <a name="input_app_desired_count"></a> [app\_desired\_count](#input\_app\_desired\_count) | Application Layer variables | `number` | n/a | yes |
| <a name="input_app_memory"></a> [app\_memory](#input\_app\_memory) | n/a | `number` | n/a | yes |
| <a name="input_db_cidrs"></a> [db\_cidrs](#input\_db\_cidrs) | CIDR blocks for database subnets | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS cluster | `string` | n/a | yes |
| <a name="input_ecs_cpu"></a> [ecs\_cpu](#input\_ecs\_cpu) | CPU units for the ECS task | `number` | n/a | yes |
| <a name="input_ecs_desired_count"></a> [ecs\_desired\_count](#input\_ecs\_desired\_count) | Desired number of ECS service tasks | `number` | n/a | yes |
| <a name="input_ecs_max_capacity"></a> [ecs\_max\_capacity](#input\_ecs\_max\_capacity) | Maximum number of ECS service tasks for auto-scaling | `number` | n/a | yes |
| <a name="input_ecs_memory"></a> [ecs\_memory](#input\_ecs\_memory) | Memory (in MiB) for the ECS task | `number` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of project environment | `string` | n/a | yes |
| <a name="input_private_cidrs"></a> [private\_cidrs](#input\_private\_cidrs) | CIDR blocks for private subnets | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of project | `string` | n/a | yes |
| <a name="input_public_cidrs"></a> [public\_cidrs](#input\_public\_cidrs) | CIDR blocks for public subnets | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region of environment | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR of VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_arn"></a> [app\_service\_arn](#output\_app\_service\_arn) | ARN of the ECS Service |
| <a name="output_app_service_name"></a> [app\_service\_name](#output\_app\_service\_name) | ECS Service name for the application |
| <a name="output_app_task_definition_arn"></a> [app\_task\_definition\_arn](#output\_app\_task\_definition\_arn) | ARN of the ECS task definition |
| <a name="output_ecr_repository_arn"></a> [ecr\_repository\_arn](#output\_ecr\_repository\_arn) | ARN of the ECR repository |
| <a name="output_ecr_repository_name"></a> [ecr\_repository\_name](#output\_ecr\_repository\_name) | Name of the ECR repository |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | URL of the ECR repository |
| <a name="output_secret_key_base"></a> [secret\_key\_base](#output\_secret\_key\_base) | Secret key base for Rails production |
| <a name="output_secret_manager_arn"></a> [secret\_manager\_arn](#output\_secret\_manager\_arn) | ARN for secret manager to use from ECS |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
