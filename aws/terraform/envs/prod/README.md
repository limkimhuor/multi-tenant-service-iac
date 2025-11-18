# prod

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

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

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
