# with Terraform

![AWS](../../../../images/aws-terraform.png)

## Install

Refer how to install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) base on your OS.

## How to use

### Initialization

#### [Terraform init](https://www.terraform.io/cli/commands/init)

1. Init specific service

- Excute `make init`

- Enter your environment and service you want to init. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

2. Init all services

- Excute `make init_all`

- Enter your environment want to init. Example:

  ```bash
  enter Environment: prod
  ```

### Deployment

#### [Terraform plan](https://www.terraform.io/cli/commands/plan)

1. Plan specific service

- Excute `make plan`(If you want to plan before destroy, excute `make plan_destroy` instead)

- Enter your environment and service you want to plan. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

2. Plan all services

- Excute `make plan_all`(If you want to plan before destroy, excute `make plan_destroy_all` instead)

- Enter your environment want to plan. Example:

  ```bash
  enter Environment: prod
  ```

#### [Terraform apply](https://www.terraform.io/cli/commands/apply)

1. Apply specific service

- Excute `make apply`

- Enter your environment and service you want to apply. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

2. Apply all services

- Excute `make apply_all`

- Enter your environment want to apply. Example:

  ```bash
  enter Environment: prod
  ```

#### [Terraform destroy](https://www.terraform.io/cli/commands/apply)

1. Destroy specific service

- Excute `make destroy`

- Enter your environment and service you want to destroy. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

2. Destroy all services

- Excute `make destroy_all`

- Enter your environment want to destroy. Example:

  ```bash
  enter Environment: prod
  ```

### Create a new service

- Create service folder in environment you want. Ex: **admin**, **general**...
- Excute `make symlink` to symlink variables.tf file from environment folder to each service folder and add this symlink file to gitignore

- Enter your environment and service you want. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

## Examples

### Structure

```
└── terraform
    └── environments
        ├── prod
        │   ├── admin
        |   │   ├── backend.tf
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   ├── general
        │   │   ├── backend.tf
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   └── terraform.tfvars
        └── stg
            ├── admin
            │   ├── backend.tf
            │   ├── main.tf
            │   ├── outputs.tf
            │   └── variables.tf
            ├── general
            │   ├── backend.tf
            │   ├── main.tf
            │   ├── outputs.tf
            │   └── variables.tf
            └── terraform.tfvars
```

### Environments

- [ ] DEV
- [x] STG
- [**Admin**](https://github.com/framgia/sun-infra-iac/blob/master/examples/aws/terraform/environments/stg/admin/README.md)
- [**General**](https://github.com/framgia/sun-infra-iac/blob/master/examples/aws/terraform/environments/stg/general/README.md)
- [x] PROD
- [**Admin**](https://github.com/framgia/sun-infra-iac/blob/master/examples/aws/terraform/environments/prod/admin/README.md)
- [**General**](https://github.com/framgia/sun-infra-iac/blob/master/examples/aws/terraform/environments/prod/general/README.md)

### Vars

- Create variables for main.tf
  - [x] variables.tf
- Values of variables for each environment
  - [x] terraform.tfvars

### Main

- Using **Modules** method
  - containers for multiple resources that are used together
  - the main way to package and reuse resource configurations with Terraform.
- [**Module Blocks**](https://www.terraform.io/language/modules/syntax#module-blocks)
- [**Module Sources from Github**](https://www.terraform.io/language/modules/sources#github) are tagged and released here <https://github.com/framgia/sun-infra-iac/tags>

Example:

```bash
module "example" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/iam-role?ref=terraform-aws-iam_v0.0.1"
}
```

### Backend

- Backends primarily determine where Terraform stores its state. Terraform uses this persisted state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.

### Outputs

- Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.
