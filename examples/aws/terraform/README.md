# with Terraform

![AWS](../../../images/aws-terraform.png)

## Install

Refer how to install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) base on your OS.

## How to use

### Initialization

#### I. Create environments & services

- Create environment folders and services folders in environment. Examples:
  - [ ] DEV
  - [x] STG
    - [**General**](../terraform/environments/stg/1.general/README.md)
    - [**Admin**](../terraform/environments/stg/2.admin/README.md)
  - [x] PROD
    - [**General**](../terraform/environments/prod/1.general/README.md)
    - [**Admin**](../terraform/environments/prod/2.admin/README.md)

- Symlink variables.tf file of environment to each service folder of it and add this symlink file to gitignore with two method

  *1. Symlink specific service*

  - Excute `make symlink`

  - Enter your environment and service you created. Example:

    ```bash
    enter Environment & Service: prod admin
    ```

  *2. Symlink all services*

  - Excute `make symlink_all`

  - Enter your environment want to init. Example:

    ```bash
    enter Environment: prod
    ```

#### [II. Terraform init](https://www.terraform.io/cli/commands/init)

*1. Init specific service*

- Excute `make init`

- Enter your environment and service you want to init. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

*2. Init all services*

- Excute `make init_all`

- Enter your environment want to init. Example:

  ```bash
  enter Environment: prod
  ```

### Deployment

#### [I. Terraform plan](https://www.terraform.io/cli/commands/plan)

*1. Plan specific service*

- Excute `make plan`(If you want to plan before destroy, excute `make plan_destroy` instead)

- Enter your environment and service you want to plan. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

*2. Plan all services*

- Excute `make plan_all`(If you want to plan before destroy, excute `make plan_destroy_all` instead)

- Enter your environment want to plan. Example:

  ```bash
  enter Environment: prod
  ```

#### [II. Terraform apply](https://www.terraform.io/cli/commands/apply)

*1. Apply specific service*

- Excute `make apply`

- Enter your environment and service you want to apply. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

*2. Apply all services*

- Excute `make apply_all`

- Enter your environment want to apply. Example:

  ```bash
  enter Environment: prod
  ```

#### [III. Terraform destroy](https://www.terraform.io/cli/commands/apply)

*1. Destroy specific service*

- Excute `make destroy`

- Enter your environment and service you want to destroy. Example:

  ```bash
  enter Environment & Service: prod admin
  ```

*2. Destroy all services*

- Excute `make destroy_all`

- Enter your environment want to destroy. Example:

  ```bash
  enter Environment: prod
  ```

## Structure

### Example

```
├── environments
│   ├── prod
│   │   ├── 1.general
│   │   │   ├── 1.1.vpc.tf
│   │   │   ├── 1.2.iam.tf
│   │   │   ├── backend.tf
│   │   │   ├── outputs.tf
│   │   │   ├── README.md
│   │   │   └── variables.tf -> /home/bui.ky.quan.sang/sun-infra-iac/examples/aws/terraform/environments/prod/variables.tf
│   │   ├── 2.admin
│   │   │   ├── 2.1.iam.tf
│   │   │   ├── backend.tf
│   │   │   ├── outputs.tf
│   │   │   ├── README.md
│   │   │   └── variables.tf -> /home/bui.ky.quan.sang/sun-infra-iac/examples/aws/terraform/environments/prod/variables.tf
│   │   ├── README.md
│   │   ├── terraform.prod.tfvars
│   │   └── variables.tf
│   └── stg
│       ├── 1.general
│       │   ├── 1.1.vpc.tf
│       │   ├── 1.2.iam.tf
│       │   ├── backend.tf
│       │   ├── outputs.tf
│       │   ├── README.md
│       │   └── variables.tf -> /home/bui.ky.quan.sang/sun-infra-iac/examples/aws/terraform/environments/stg/variables.tf
│       ├── 2.admin
│       │   ├── 2.1.iam.tf
│       │   ├── backend.tf
│       │   ├── outputs.tf
│       │   ├── README.md
│       │   └── variables.tf -> /home/bui.ky.quan.sang/sun-infra-iac/examples/aws/terraform/environments/stg/variables.tf
│       ├── README.md
│       ├── terraform.stg.tfvars
│       └── variables.tf
├── README.md
└── templates
    ├── codebuild
    │   └── buildspec.yml
    ├── codedeploy
    │   ├── appspec.yml
    │   └── hooks
    │       ├── 1.pull-and-config.sh
    │       ├── 2.build-and-deploy.sh
    │       ├── 3.start.sh
    │       └── 4.validate.sh
    └── policy
        ├── assume-role-lambda.json
        └── lambda-example-admin.json
```

### Vars

- Create variables for main
  - [x] variables.tf
- Values of variables for each environment
  - [x] terraform.stg.tfvars
  - [x] terraform.prod.tfvars

### Main

- Using **Modules** method
  - containers for multiple resources that are used together
  - the main way to package and reuse resource configurations with Terraform.
- [**Module Blocks**](https://www.terraform.io/language/modules/syntax#module-blocks)
- [**Module Sources from Github**](https://www.terraform.io/language/modules/sources#github) are tagged and released here <https://github.com/framgia/sun-infra-iac/tags>

Example:

```bash
module "example" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/iam-role?ref=terraform-aws-iam_v0.0.4"
}
```

### Backend

- Backends primarily determine where Terraform stores its state. Terraform uses this persisted state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.

### Outputs

- Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.
