# 🚀 A-Z Terraform AWS Guide for Beginners

> **Comprehensive tutorial from basics to advanced** for deploying Infrastructure as Code with Terraform on AWS

<br>

## 📋 Table of Contents

| **Section** | **Content** | **Difficulty** |
|-------------|-------------|----------------|
| **1.** | [📝 Introduction to Terraform and AWS](#1-📝-introduction-to-terraform-and-aws) | ⭐ |
| **2.** | [🔧 Installation and Environment Setup](#2-🔧-installation-and-environment-setup) | ⭐ |
| **3.** | [🔐 AWS Setup and Credential Configuration](#3-🔐-aws-setup-and-credential-configuration) | ⭐⭐ |
| **4.** | [📁 Project Structure](#4-📁-project-structure) | ⭐⭐ |
| **5.** | [🗄️ Initializing Backend and State Management](#5-🗄️-initializing-backend-and-state-management) | ⭐⭐ |
| **6.** | [🚀 Deploying Your First Infrastructure](#6-🚀-deploying-your-first-infrastructure) | ⭐⭐ |
| **7.** | [🌍 Managing Environments](#7-🌍-managing-environments) | ⭐⭐⭐ |
| **8.** | [📦 Using Existing Modules](#8-📦-using-existing-modules) | ⭐⭐⭐ |
| **9.** | [🔧 Writing Your Own Modules](#9-🔧-writing-your-own-modules) | ⭐⭐⭐⭐ |
| **10.** | [🔧 Advanced: CI/CD with terraform-dependencies](#10-🔧-advanced-cicd-with-terraform-dependencies) | ⭐⭐⭐⭐ |
| **11.** | [⭐ Best Practices and Troubleshooting](#11-⭐-best-practices-and-troubleshooting) | ⭐⭐⭐ |
| **12.** | [💻 References](#12-💻-references) | ⭐⭐ |

---

<br>

# 1. 📝 Introduction to Terraform and AWS

## 💡 What is Terraform?

**Terraform** is an Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to:

| **Feature** | **Benefit** |
|-------------|-------------|
| 🔧 **Define infrastructure with code** | Instead of manually creating resources on AWS Console |
| 📝 **Version control** | Manage infrastructure versions like source code |
| 🤖 **Automation** | Automate creation, updates, and deletion of resources |
| ✅ **Consistency** | Ensure consistency across environments |

<br>

## 🎯 Why use Terraform with AWS?

- **🚀 Scalability**: Easily scale your infrastructure
- **💰 Cost Management**: Better control over costs
- **👥 Collaboration**: Multiple people can work together
- **🔄 Disaster Recovery**: Quickly recover infrastructure

<br>

## 📚 Basic Concepts

| **Concept** | **Explanation** | **Example** |
|-------------|----------------|-------------|
| **Resource** | Infrastructure components | EC2, VPC, S3, RDS |
| **Provider** | Connects with cloud provider | AWS, Azure, GCP |
| **State** | Current state of infrastructure | `.tfstate` file |
| **Module** | Reusable collection of resources | VPC module, EC2 module |

---

<br>

# 2. 🔧 Installation and Environment Setup

## ⚙️ Install Necessary Tools

### 🔄 Git - Source code management

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y git

# MacOS
brew install git

# Check installation
git --version
```

<br>

### 🏗️ Terraform - Main tool

```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# MacOS
brew install terraform

# Check installation
terraform --version
```

<br>

### ☁️ AWS CLI - Interact with AWS

```bash
# Ubuntu/Debian
sudo apt install -y awscli

# MacOS
brew install awscli

# Check installation
aws --version
```

<br>

### 🛠️ Make - Automation with Makefile

```bash
# Ubuntu/Debian
sudo apt install -y make

# MacOS
brew install make

# Check installation
make --version
```

<br>

## 📂 Clone repository

```bash
# Create working directory
mkdir ~/terraform-projects
cd ~/terraform-projects

# Clone repository
git clone git@github.com:sun-asterisk-internal/sun-infra-iac.git
cd sun-infra-iac

# Rename project according to your project
mv sun-infra-iac my-awesome-project
cd my-awesome-project

# Focus on AWS
# 1. Open File Manager/Explorer
# 2. Copy "examples/aws" folder out to become "aws" folder
# 3. Delete "examples" directory (no longer needed)
```

<br>

## 📝 How to create/edit files

In this guide, we will need to create and edit many files. You can use the following text editors:

| **Editor** | **Platform** | **How to open** |
|------------|--------------|-----------------|
| **VS Code** | All | Open VS Code → Open Folder → Select project directory |
| **Notepad++** | Windows | Create new file, copy content, Save As |
| **TextEdit** | MacOS | Applications → TextEdit |
| **Gedit** | Linux | `gedit filename` |
---

<br>

# 3. 🔐 AWS Setup and Credential Configuration

## 👤 Create AWS Account and IAM User

### Step 1️⃣: Create AWS Account (Optional)

> **Note**: If you already have an AWS Account, you can skip this step and go directly to Step 2.

1. Go to [aws.amazon.com](https://aws.amazon.com)
2. Register for a new account
3. Verify payment information

<br>

### Step 2️⃣: Create IAM User for Terraform

| **Step** | **Action** | **Value** |
|----------|------------|-----------|
| 1 | Login to AWS Console → Search "IAM" | |
| 2 | Users → Add user | |
| 3 | Username | `terraform-user` |
| 4 | Access type | ✅ Programmatic access |
| 5 | Permissions | ✅ `AdministratorAccess` |
| 6 | Review → Create user | |
| 7 | **⚠️ SAVE** | Access Key ID + Secret Access Key |

<br>

> ### 🚨 SECURITY WARNING
> 
> - **NEVER** share or expose your Access Key ID and Secret Access Key
> - This information has **AdministratorAccess** - can create/delete all AWS resources
> - If exposed, malicious actors can create expensive resources → **resulting in high costs**
> - Store securely, don't commit to Git, don't send via chat/email
> - If you suspect compromise → **Deactivate immediately** in AWS Console

<br>

### Step 3️⃣: Set up MFA (Recommended)

1. In the newly created IAM User → **Security credentials**
2. **Multi-factor authentication** → **Assign MFA device**
3. Choose **Virtual MFA device**
4. Use an app like Google Authenticator or Authy
5. Save the **MFA device name** (usually the `username`)

<br>

## ⚙️ Configure AWS CLI

### 🔹 If NOT using MFA:

```bash
aws configure --profile myproject-dev
```

**Enter information when prompted:**
- **AWS Access Key ID**: (from Step 2)
- **AWS Secret Access Key**: (from Step 2)
- **Default region**: `ap-northeast-1`
- **Default output format**: `json`

<br>

### 🔹 If USING MFA:

#### Step 1: Create main profile

```bash
aws configure --profile myproject-default
```

**Enter information:**
- **AWS Access Key ID**: (from Step 2)
- **AWS Secret Access Key**: (from Step 2)
- **Default region**: `ap-northeast-1`
- **Default output format**: `json`

<br>

#### Step 2: Create temporary profile for Terraform

**Create/edit `~/.aws/credentials` file:**

| **Platform** | **Path** |
|--------------|----------|
| Linux/Mac | `/home/username/.aws/credentials` |
| Windows | `C:\Users\username\.aws\credentials` |

**Add the following content to end of file:**

```ini
[myproject-dev]
aws_access_key_id = 
aws_secret_access_key = 
aws_session_token = 
```

<br>

#### Step 3: Create config for profile

**Create/edit `~/.aws/config` file:**

```ini
[profile myproject-dev]
output = json
region = ap-northeast-1
```

<br>

## 🔑 Use script to create temporary credentials (with MFA)

```bash
cd aws
chmod +x create-aws-sts.sh

# Run script
./create-aws-sts.sh myproject-default myproject-dev <account-id> <iam-username> <mfa-token>
```

**Parameter explanation:**

| **Parameter** | **Explanation** | **Example** |
|---------------|----------------|-------------|
| `myproject-default` | Main profile with MFA | (from Step 1) |
| `myproject-dev` | Temporary profile for Terraform | (from Step 2) |
| `<account-id>` | AWS Account ID (12 digits) | Find in AWS Console → IAM |
| `<iam-username>` | IAM user name | `terraform-user` |
| `<mfa-token>` | 6-digit code from MFA app | `123456` |

> **📝 Note:** This script needs to be run every time the session token expires (usually 12 hours).

---

<br>

# 4. 📁 Project Structure

## 🏗️ General Structure

```text
aws/
├── Makefile                    # Automation commands
├── pre-build.sh               # Script to create backend resources
├── create-aws-sts.sh          # Script to create MFA credentials
├── terraform/
│   ├── envs/                  # Environments
│   │   ├── dev/               # Development environment
│   │   ├── stg/               # Staging environment
│   │   └── prod/              # Production environment
│   └── README.md
└── terraform-dependencies/    # Supporting scripts and configs
    ├── codebuild/
    ├── codedeploy/
    └── lambda-function/
```

<br>

## 📦 Explanation of terraform-dependencies folder

> **Contains template files and scripts that support AWS CI/CD services**

```text
terraform-dependencies/
├── codebuild/
│   └── buildspec.yml          # Template for AWS CodeBuild
├── codedeploy/
│   ├── appspec.yml           # Template for AWS CodeDeploy
│   └── hooks/                # Scripts that run in different phases
│       ├── 1.pull-and-config.sh
│       ├── 2.build-and-deploy.sh  
│       ├── 3.start.sh
│       └── 4.validate.sh
└── lambda-function/          # Template code for AWS Lambda
```

**🎯 Purpose of the files:**

| **File/Folder** | **Purpose** | **When to use** |
|-----------------|-------------|-----------------|
| `codebuild/buildspec.yml` | **Template** defining build steps | Creating CodeBuild project for CI/CD |
| `codedeploy/appspec.yml` | **Template** defining how to deploy app | Creating CodeDeploy application |
| `codedeploy/hooks/` | **Scripts** that run in each deployment phase | Customizing deployment logic |

**💡 How to use:**
1. **Copy templates**: When creating CI/CD pipeline, copy these files into your application project
2. **Customize**: Edit content to fit your specific application
3. **Reference in Terraform**: Use in terraform modules to create CodeBuild/CodeDeploy

<br>

## 🌍 Environment Structure

```text
terraform/envs/dev/
├── _variables.tf              # Shared variables
├── terraform.dev.tfvars       # Variable values for dev
├── 1.general/                 # Basic services (VPC, IAM...)
├── 2.admin/                   # Admin services
├── 3.database/                # Database services
├── 4.deployment/              # CI/CD services
└── 5.monitoring/              # Monitoring services
```

**🗂️ Folder classification:**

| **Folder** | **Purpose** | **Example services** |
|------------|-------------|---------------------|
| **1.general/** | Common infrastructure | VPC, IAM, S3, KMS, Route53 |
| **2.admin/** | System administration | IAM users, admin policies, backup configs |
| **3.database/** | Database | RDS, DynamoDB, ElastiCache, DocumentDB |
| **4.deployment/** | CI/CD Pipeline | CodePipeline, CodeBuild, CodeDeploy, ECR |
| **5.monitoring/** | Monitoring & Alerting | CloudWatch, EventBridge, SNS, CloudTrail |

<br>

## 📄 Important file explanations

### 🔧 Service folder structure

```text
1.general/
├── _backend.tf            # Backend config + AWS connection
├── _data.tf               # FETCH existing info from AWS
├── _outputs.tf            # EXPORT info for other services
├── _variables.tf          # Symlink to ../_variables.tf
├── vpc.tf                 # CREATE VPC and network resources
├── iam.tf                 # CREATE IAM roles and permissions
└── <service>.tf           # CREATE additional services
```

**💡 File classification:**

| **File** | **Purpose** | **Example** |
|----------|-------------|-------------|
| `_backend.tf` | State storage config + AWS connection | S3 backend, AWS provider |
| `_data.tf` | **FETCH** existing info from AWS | List of AZs, latest AMI |
| `_outputs.tf` | **EXPORT** info for other services | VPC ID, Subnet IDs |
| `vpc.tf` | **CREATE** VPC and network resources | VPC, subnets, internet gateway |
| `iam.tf` | **CREATE** IAM roles and permissions | Roles for EC2, Lambda |

<br>

## 📝 Configuration file details

### 🔹 _variables.tf - Variable definitions

```hcl
variable "project" {
  description = "Name of project"
  type        = string
}

variable "env" {
  description = "Environment (dev/stg/prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
```

<br>

### 🔹 terraform.dev.tfvars - Variable values

```hcl
project = "my-awesome-project"
env     = "dev"
region  = "ap-northeast-1"
```

<br>

### 🔹 _backend.tf - State storage configuration

```hcl
terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  backend "s3" {
    profile        = "myproject-dev"                    # ← From section 3: AWS CLI profile
    bucket         = "myproject-dev-iac-state"          # ← From section 5: S3 bucket name
    key            = "1.general/terraform.dev.tfstate"  # ← State file path in bucket
    region         = "ap-northeast-1"                   # ← Deployment region
    encrypt        = true                               # ← Always enable encryption
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/abc-def-ghi"  # ← KMS Key ARN
    dynamodb_table = "myproject-dev-terraform-state-lock"  # ← DynamoDB table
  }
}

provider "aws" {
  region  = var.region                    # ← Use variable from tfvars
  profile = "${var.project}-${var.env}"   # ← Auto generate profile name
  default_tags {
    tags = {
      Project     = var.project          # ← Auto tag for all resources
      Environment = var.env              # ← Environment tag
    }
  }
}
```

**💡 Information to update:**

| **Parameter** | **Get from** | **Example** |
|---------------|--------------|-------------|
| `profile` | Section 3 - AWS CLI profile | `myproject-dev` |
| `bucket` | Section 5 - Created by pre-build.sh | `myproject-dev-iac-state` |
| `region` | Section 3 - Selected region | `ap-northeast-1` |
| `kms_key_id` | Section 5 - Script output | `arn:aws:kms:...` |
| `dynamodb_table` | Section 5 - Auto-created by script | `myproject-dev-terraform-state-lock` |

---

<br>

# 5. 🗄️ Initializing Backend and State Management

## 🤔 What is Backend and Why Do We Need It?

### 📊 Terraform State

> **Terraform State** = File containing information about all created resources (like an asset inventory)

**🚨 Problem with local storage:**
- ❌ Only you can manage it
- ❌ Lose file = lose infrastructure management capability
- ❌ Cannot work as a team
- ❌ No backup

**✅ Solution: Remote Backend (AWS S3):**
- ✅ Enable team collaboration
- ✅ Automatic backup
- ✅ Avoid conflicts when multiple people run simultaneously
- ✅ Security with encryption

<br>

### 🏗️ Requires 3 main components

| **Component** | **Purpose** | **AWS Service** |
|---------------|-------------|-----------------|
| **🗄️ State Storage** | Store state file | S3 Bucket |
| **🔒 State Locking** | Lock when someone is running | DynamoDB Table |
| **🔐 Encryption** | Encrypt state file | KMS Key |

<br>

## 🚀 Automatically create backend with script

```bash
cd aws
chmod +x pre-build.sh
./pre-build.sh
```

**Script will ask for 3 inputs:**

| **Information** | **Example** | **Description** |
|----------------|-------------|-----------------|
| **Project Name** | `myproject` | Your project name |
| **ENV** | `dev` | Environment (dev/stg/prod) |
| **Region** | `ap-northeast-1` | AWS deployment region |

> **💡 Note:** Change these values to match your project

<br>

### 📦 Resources created automatically

Script will automatically create 3 AWS resources:

| **Resource** | **Name will be created** | **Purpose** |
|--------------|-------------------------|-------------|
| **S3 Bucket** | `myproject-dev-iac-state` | Store state files |
| **DynamoDB Table** | `myproject-dev-terraform-state-lock` | State locking |
| **KMS Key** | `alias/myproject-dev-iac` | Encryption |

> **❗ Important:** Script will display **KMS Key ARN** at the end → **Copy this ARN** for the next step

<br>

## ⚙️ Update backend configuration

After running the script, copy **KMS Key ARN** and update it in `_backend.tf`:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-dev"
    bucket         = "myproject-dev-iac-state"
    key            = "1.general/terraform.dev.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/abc-def-ghi"  # ← Paste KMS ARN here
    dynamodb_table = "myproject-dev-terraform-state-lock"
  }
}
```

**🔧 Change the values:**
1. `myproject` → Your actual project name
2. `dev` → Your environment
3. `ap-northeast-1` → Your region
4. `kms_key_id` → KMS ARN from script output

---

<br>

# 6. 🚀 Deploying Your First Infrastructure

## 🛠️ Prepare the dev environment

### Step 1️⃣: Update variables

**Create file `terraform/envs/dev/terraform.dev.tfvars`:**

```hcl
project = "myproject"          # ← Change to your project name
env     = "dev"
region  = "ap-northeast-1"
```

<br>

### Step 2️⃣: Create symlinks for variables

```bash
cd aws
make symlink e=dev s=general
```

> **💡 What is a symlink?**
> 
> Symlink (symbolic link) is a "shortcut" pointing to another file, like a desktop shortcut.
> 
> **Why use symlinks here?**
> - The `_variables.tf` file in `envs/dev/` contains all variables for the `dev` environment
> - Each service (`1.general`, `2.database`...) needs to use this shared file
> - Instead of copying the file → create a symlink so all services "see" the same source file
> - When variables change → all services update automatically

<br>

## 🏗️ Deploying Your First VPC

### Step 1️⃣: Check VPC configuration

```bash
# View VPC file content
cat terraform/envs/dev/1.general/vpc.tf
```

<br>

### Step 2️⃣: Initialize Terraform

```bash
make init e=dev s=general
```

**This command will:**
- ⬇️ Download AWS provider
- 🔗 Initialize S3 backend
- 📄 Create state file

<br>

### Step 3️⃣: Plan - Preview what will be created

```bash
make plan e=dev s=general
```

**Terraform will display:**

| **Symbol** | **Meaning** | **Example** |
|------------|-------------|-------------|
| **`+`** | Resources to be **created** | `+ aws_vpc.main` |
| **`~`** | Resources to be **updated** | `~ aws_instance.web` |
| **`-`** | Resources to be **deleted** | `- aws_s3_bucket.old` |

<br>

### Step 4️⃣: Apply - Actually deploy

```bash
make apply e=dev s=general
```

1. **Review the plan** one more time
2. **Type `yes`** to confirm deployment
3. **Wait for Terraform to create resources** according to the plan

> **⏱️ Duration:** Usually takes 2-5 minutes to create VPC and related resources

<br>

## ✅ Check the results

### 🖥️ On AWS Console

**Check the resources that were created:**

| **Service** | **Where to find** | **Resource name** |
|-------------|-------------------|-------------------|
| **VPC** | VPC Dashboard | `myproject-dev-vpc` |
| **Subnets** | VPC → Subnets | Public & Private subnets |
| **Internet Gateway** | VPC → Internet Gateways | `myproject-dev-igw` |
| **NAT Gateway** | VPC → NAT Gateways | `myproject-dev-nat-*` |

<br>

### 💻 With Terraform commands

```bash
# View list of all resources
make state_list e=dev s=general

# View VPC details
make state_show e=dev s=general t='module.vpc.aws_vpc.vpc'

# View outputs
terraform output -state=terraform/envs/dev/1.general/terraform.tfstate
```

<br>

## 🎯 Expected results

After successful deployment, you will have:

```
AWS Resources created:
├── VPC (myproject-dev-vpc)
├── Public Subnets (2 AZ)
├── Private Subnets (2 AZ)
├── Internet Gateway
├── NAT Gateways (2 AZ)
├── Route Tables
└── Security Groups (default)
```

**🎉 Congratulations!** You have successfully deployed your first infrastructure with Terraform!

**💡 Benefit:** Your code will automatically work in any region without hardcoding AZ names (e.g., `ap-northeast-1a`, `ap-northeast-1c`).

---

<br>

# 7. 🌍 Managing Environments

### 7.1 Create a staging environment

Steps are similar to **dev environment** in section 6.1, just change `dev` → `stg`.

<details>
<summary>📋 <strong>Detailed steps to create Staging environment</strong></summary>

#### Step 1: Copy structure from dev
1. Open File Manager/Explorer
2. Copy the `terraform/envs/dev` folder
3. Paste and rename to `terraform/envs/stg`

#### Step 2: Update configs for staging
1. Open text editor
2. Open file: `terraform/envs/stg/terraform.stg.tfvars`
3. Edit content to:

```hcl
project = "myproject"
env     = "stg"  # ← Change env
region  = "ap-northeast-1"
```

#### Step 3: Update backend for staging
1. Open text editor
2. Open file: `terraform/envs/stg/1.general/_backend.tf`
3. Edit content to:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-stg"          # ← Change profile
    bucket         = "myproject-stg-iac-state" # ← Change bucket
    key            = "1.general/terraform.stg.tfstate" # ← Change key
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/xyz-abc-def" # ← KMS key for stg
    dynamodb_table = "myproject-stg-terraform-state-lock" # ← DynamoDB for stg
  }
}
```

#### Step 4: Create backend resources for staging
```bash
./pre-build.sh
# Enter: myproject, stg, ap-northeast-1
```

#### Step 5: Deploy staging
```bash
make symlink e=stg s=general
make init e=stg s=general
make plan e=stg s=general
make apply e=stg s=general
```

</details>

### 7.2 Create a production environment

Steps are similar to **Steps 1-5** in section 7.1, just change `stg` → `prod`.

<details>
<summary>📋 <strong>Detailed steps to create Production environment</strong></summary>

#### Step 1: Copy structure from dev
1. Open File Manager/Explorer
2. Copy the `terraform/envs/dev` folder
3. Paste and rename to `terraform/envs/prod`

#### Step 2: Update configs for production
1. Open text editor
2. Open file: `terraform/envs/prod/terraform.prod.tfvars`
3. Edit content to:

```hcl
project = "myproject"
env     = "prod"  # ← Change env
region  = "ap-northeast-1"
```

#### Step 3: Update backend for production
1. Open text editor
2. Open file: `terraform/envs/prod/1.general/_backend.tf`
3. Edit content to:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-prod"          # ← Change profile
    bucket         = "myproject-prod-iac-state" # ← Change bucket
    key            = "1.general/terraform.prod.tfstate" # ← Change key
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/xyz-abc-def" # ← KMS key for prod
    dynamodb_table = "myproject-prod-terraform-state-lock" # ← DynamoDB for prod
  }
}
```

#### Step 4: Create backend resources for production
```bash
./pre-build.sh
# Enter: myproject, prod, ap-northeast-1
```

#### Step 5: Deploy production
```bash
make symlink e=prod s=general
make init e=prod s=general
make plan e=prod s=general
make apply e=prod s=general
```

</details>

**⚠️ Note for Production:**
- Deploy multi-region for high availability
- Configure automatic backup
- Set up monitoring and alerting
- Review carefully before applying

---

<br>

# 8. 📦 Using Existing Modules

### 8.1 Understanding Terraform Modules

**Module** is a way to package and reuse Terraform code. Instead of rewriting code, you use existing modules.

**💡 Benefits of modules:**
- ✅ **Reusability**: No need to rewrite code
- ✅ **Consistency**: Ensure consistent configuration
```
terraform/envs/dev/
├── _variables.tf              # Shared variables
├── terraform.dev.tfvars       # Variable values for dev
├── 1.general/                 # Basic services (VPC, IAM...)
│   ├── _backend.tf            # Backend config and AWS connection
│   ├── _data.tf               # Fetch info from AWS (AZ, AMI...)
│   ├── _outputs.tf            # Export info for other services
│   ├── _variables.tf          # Symlink to ../_variables.tf
│   ├── vpc.tf                 # Create VPC, subnets, gateways
│   ├── iam.tf                 # Create IAM roles, policies
│   └── <service_name>.tf      # Other services (s3.tf, kms.tf, route53.tf...)
├── 2.admin/                   # Admin services
│                              # For admin-related services (IAM users, policies...)
├── 3.database/                # Database services
│                              # For DB services (RDS, DynamoDB, ElastiCache...)
├── 4.deployment/              # CI/CD services
│                              # For CI/CD services (CodePipeline, CodeBuild, CodeDeploy...)
└── 5.monitoring/              # Monitoring services
                               # For monitoring services (CloudWatch, EventBridge, SNS...)
```

**🗂️ Folder details:**

| **Folder** | **Purpose** | **Example services** |
|------------|-------------|---------------------|
| **1.general/** | Common infrastructure | VPC, IAM, S3, KMS, Route53 |
| **2.admin/** | System administration | IAM users, admin policies, backup configs |
| **3.database/** | Database | RDS, DynamoDB, ElastiCache, DocumentDB |
| **4.deployment/** | CI/CD Pipeline | CodePipeline, CodeBuild, CodeDeploy, ECR |
| **5.monitoring/** | Monitoring & Alerting | CloudWatch, EventBridge, SNS, CloudTrail |

<br>

## � Important file explanations

### 🔧 Service folder structure

```text
1.general/
├── _backend.tf            # Backend config + AWS connection
├── _data.tf               # FETCH existing info from AWS
├── _outputs.tf            # EXPORT info for other services
├── _variables.tf          # Symlink to ../_variables.tf
├── vpc.tf                 # CREATE VPC and network resources
├── iam.tf                 # CREATE IAM roles and permissions
└── <service>.tf           # CREATE additional services
```

**💡 File classification:**

| **File** | **Purpose** | **Example** |
|----------|-------------|-------------|
| `_backend.tf` | State storage config + AWS connection | S3 backend, AWS provider |
| `_data.tf` | **FETCH** existing info from AWS | List of AZs, latest AMI |
| `_outputs.tf` | **EXPORT** info for other services | VPC ID, Subnet IDs |
| `vpc.tf` | **CREATE** VPC and network resources | VPC, subnets, internet gateway |
| `iam.tf` | **CREATE** IAM roles and permissions | Roles for EC2, Lambda |

<br>

## 📝 Configuration file details

### 🔹 _variables.tf - Variable definitions

```hcl
variable "project" {
  description = "Name of project"
  type        = string
}

variable "env" {
  description = "Environment (dev/stg/prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
```

<br>

### 🔹 terraform.dev.tfvars - Variable values

```hcl
project = "my-awesome-project"
env     = "dev"
region  = "ap-northeast-1"
```

<br>

### 🔹 _backend.tf - State storage configuration

```hcl
terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  backend "s3" {
    profile        = "myproject-dev"                    # ← From section 3: AWS CLI profile
    bucket         = "myproject-dev-iac-state"          # ← From section 5: S3 bucket name
    key            = "1.general/terraform.dev.tfstate"  # ← State file path in bucket
    region         = "ap-northeast-1"                   # ← Deployment region
    encrypt        = true                               # ← Always enable encryption
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/abc-def-ghi"  # ← KMS Key ARN
    dynamodb_table = "myproject-dev-terraform-state-lock"  # ← DynamoDB table
  }
}

provider "aws" {
  region  = var.region                    # ← Use variable from tfvars
  profile = "${var.project}-${var.env}"   # ← Auto generate profile name
  default_tags {
    tags = {
      Project     = var.project          # ← Auto tag for all resources
      Environment = var.env              # ← Environment tag
    }
  }
}
```

---

<br>

# 5. 🗄️ Initializing Backend and State Management

## 🤔 What is Backend and Why Do We Need It?

### 📊 Terraform State

> **Terraform State** = File containing information about all created resources (like an asset inventory)

**🚨 Problem with local storage:**
- ❌ Only you can manage it
- ❌ Lose file = lose infrastructure management capability
- ❌ Cannot work as a team
- ❌ No backup

**✅ Solution: Remote Backend (AWS S3):**
- ✅ Enable team collaboration
- ✅ Automatic backup
- ✅ Avoid conflicts when multiple people run simultaneously
- ✅ Security with encryption

<br>

### 🏗️ Requires 3 main components

| **Component** | **Purpose** | **AWS Service** |
|---------------|-------------|-----------------|
| **🗄️ State Storage** | Store state file | S3 Bucket |
| **🔒 State Locking** | Lock when someone is running | DynamoDB Table |
| **🔐 Encryption** | Encrypt state file | KMS Key |

<br>

## 🚀 Automatically create backend with script

```bash
cd aws
chmod +x pre-build.sh
./pre-build.sh
```

**Script will ask for 3 inputs:**

| **Information** | **Example** | **Description** |
|----------------|-------------|-----------------|
| **Project Name** | `myproject` | Your project name |
| **ENV** | `dev` | Environment (dev/stg/prod) |
| **Region** | `ap-northeast-1` | AWS deployment region |

> **💡 Note:** Change these values to match your project

<br>

### 📦 Resources created automatically

Script will automatically create 3 AWS resources:

| **Resource** | **Name will be created** | **Purpose** |
|--------------|-------------------------|-------------|
| **S3 Bucket** | `myproject-dev-iac-state` | Store state files |
| **DynamoDB Table** | `myproject-dev-terraform-state-lock` | State locking |
| **KMS Key** | `alias/myproject-dev-iac` | Encryption |

> **❗ Important:** Script will display **KMS Key ARN** at the end → **Copy this ARN** for the next step

<br>

## ⚙️ Update backend configuration

After running the script, copy **KMS Key ARN** and update it in `_backend.tf`:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-dev"
    bucket         = "myproject-dev-iac-state"
    key            = "1.general/terraform.dev.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/abc-def-ghi"  # ← Paste KMS ARN here
    dynamodb_table = "myproject-dev-terraform-state-lock"
  }
}
```

**🔧 Change the values:**
1. `myproject` → Your actual project name
2. `dev` → Your environment
3. `ap-northeast-1` → Your region
4. `kms_key_id` → KMS ARN from script output

---

<br>

# 6. 🚀 Deploying Your First Infrastructure

## 🛠️ Prepare the dev environment

### Step 1️⃣: Update variables

**Create file `terraform/envs/dev/terraform.dev.tfvars`:**

```hcl
project = "myproject"          # ← Change to your project name
env     = "dev"
region  = "ap-northeast-1"
```

<br>

### Step 2️⃣: Create symlinks for variables

```bash
cd aws
make symlink e=dev s=general
```

> **💡 What is a symlink?**
> 
> Symlink (symbolic link) is a "shortcut" pointing to another file, like a desktop shortcut.
> 
> **Why use symlinks here?**
> - The `_variables.tf` file in `envs/dev/` contains all variables for the `dev` environment
> - Each service (`1.general`, `2.database`...) needs to use this shared file
> - Instead of copying the file → create a symlink so all services "see" the same source file
> - When variables change → all services update automatically

<br>

## 🏗️ Deploying Your First VPC

### Step 1️⃣: Check VPC configuration

```bash
# View VPC file content
cat terraform/envs/dev/1.general/vpc.tf
```

<br>

### Step 2️⃣: Initialize Terraform

```bash
make init e=dev s=general
```

**This command will:**
- ⬇️ Download AWS provider
- 🔗 Initialize S3 backend
- 📄 Create state file

<br>

### Step 3️⃣: Plan - Preview what will be created

```bash
make plan e=dev s=general
```

**Terraform will display:**

| **Symbol** | **Meaning** | **Example** |
|------------|-------------|-------------|
| **`+`** | Resources to be **created** | `+ aws_vpc.main` |
| **`~`** | Resources to be **updated** | `~ aws_instance.web` |
| **`-`** | Resources to be **deleted** | `- aws_s3_bucket.old` |

<br>

### Step 4️⃣: Apply - Actually deploy

```bash
make apply e=dev s=general
```

1. **Review the plan** one more time
2. **Type `yes`** to confirm deployment
3. **Wait for Terraform to create resources** according to the plan

> **⏱️ Duration:** Usually takes 2-5 minutes to create VPC and related resources

<br>

## ✅ Check the results

### 🖥️ On AWS Console

**Check the resources that were created:**

| **Service** | **Where to find** | **Resource name** |
|-------------|-------------------|-------------------|
| **VPC** | VPC Dashboard | `myproject-dev-vpc` |
| **Subnets** | VPC → Subnets | Public & Private subnets |
| **Internet Gateway** | VPC → Internet Gateways | `myproject-dev-igw` |
| **NAT Gateway** | VPC → NAT Gateways | `myproject-dev-nat-*` |

<br>

### 💻 With Terraform commands

```bash
# View list of all resources
make state_list e=dev s=general

# View VPC details
make state_show e=dev s=general t='module.vpc.aws_vpc.vpc'

# View outputs
terraform output -state=terraform/envs/dev/1.general/terraform.tfstate
```

<br>

## 🎯 Expected results

After successful deployment, you will have:

```
AWS Resources created:
├── VPC (myproject-dev-vpc)
├── Public Subnets (2 AZ)
├── Private Subnets (2 AZ)
├── Internet Gateway
├── NAT Gateways (2 AZ)
├── Route Tables
└── Security Groups (default)
```

**🎉 Congratulations!** You have successfully deployed your first infrastructure with Terraform!


**💡 Benefit:** Your code will automatically work in any region without hardcoding AZ names (e.g., `ap-northeast-1a`, `ap-northeast-1c`).

---

## 7. 🌍 Managing Environments

### 7.1 Create a staging environment

Steps are similar to **dev environment** in section 6.1, just change `dev` → `stg`.

<details>
<summary>📋 <strong>Detailed steps to create Staging environment</strong></summary>

#### Step 1: Copy structure from dev
1. Open File Manager/Explorer
2. Copy the `terraform/envs/dev` folder
3. Paste and rename to `terraform/envs/stg`

#### Step 2: Update configs for staging
1. Open text editor
2. Open file: `terraform/envs/stg/terraform.stg.tfvars`
3. Edit content to:

```hcl
project = "myproject"
env     = "stg"  # ← Change env
region  = "ap-northeast-1"
```

#### Step 3: Update backend for staging
1. Open text editor
2. Open file: `terraform/envs/stg/1.general/_backend.tf`
3. Edit content to:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-stg"          # ← Change profile
    bucket         = "myproject-stg-iac-state" # ← Change bucket
    key            = "1.general/terraform.stg.tfstate" # ← Change key
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/xyz-abc-def" # ← KMS key for stg
    dynamodb_table = "myproject-stg-terraform-state-lock" # ← DynamoDB for stg
  }
}
```

#### Step 4: Create backend resources for staging
```bash
./pre-build.sh
# Enter: myproject, stg, ap-northeast-1
```

#### Step 5: Deploy staging
```bash
make symlink e=stg s=general
make init e=stg s=general
make plan e=stg s=general
make apply e=stg s=general
```

</details>

### 7.2 Create a production environment

Steps are similar to **Steps 1-5** in section 7.1, just change `stg` → `prod`.

<details>
<summary>📋 <strong>Detailed steps to create Production environment</strong></summary>

#### Step 1: Copy structure from dev
1. Open File Manager/Explorer
2. Copy the `terraform/envs/dev` folder
3. Paste and rename to `terraform/envs/prod`

#### Step 2: Update configs for production
1. Open text editor
2. Open file: `terraform/envs/prod/terraform.prod.tfvars`
3. Edit content to:

```hcl
project = "myproject"
env     = "prod"  # ← Change env
region  = "ap-northeast-1"
```

#### Step 3: Update backend for production
1. Open text editor
2. Open file: `terraform/envs/prod/1.general/_backend.tf`
3. Edit content to:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-prod"          # ← Change profile
    bucket         = "myproject-prod-iac-state" # ← Change bucket
    key            = "1.general/terraform.prod.tfstate" # ← Change key
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/xyz-abc-def" # ← KMS key for prod
    dynamodb_table = "myproject-prod-terraform-state-lock" # ← DynamoDB for prod
  }
}
```

#### Step 4: Create backend resources for production
```bash
./pre-build.sh
# Enter: myproject, prod, ap-northeast-1
```

#### Step 5: Deploy production
```bash
make symlink e=prod s=general
make init e=prod s=general
make plan e=prod s=general
make apply e=prod s=general
```

</details>

**⚠️ Note for Production:**
- Deploy multi-region for high availability
- Configure automatic backup
- Set up monitoring and alerting
- Review carefully before applying

---

## 8. 📦 Using Existing Modules

### 8.1 Understanding Terraform Modules

**Module** is a way to package and reuse Terraform code. Instead of rewriting code, you use existing modules.

**💡 Benefits of modules:**
- ✅ **Reusability**: No need to rewrite code
- ✅ **Consistency**: Ensure consistent configuration
- ✅ **Best practices**: Modules are already optimized
- ✅ **Time saving**: Save development time

### 8.2 Finding and using modules

**💡 NOTE:** Sun Asterisk has written many common modules that you can use directly without rewriting from scratch!

<details>
<summary>📋 <strong>Detailed guide for finding and using modules</strong></summary>

#### **Step 1: Access Module Repository**
1. Open link: https://github.com/sun-asterisk-internal/sun-infra-iac
2. Navigate to the modules folder to see available modules

#### **Step 2: Find appropriate Module Version**
1. Click **Branches** → select **Tags**
2. Search by pattern: `terraform-aws-<service>_v<version>`
3. Example: Want to create S3 bucket → find `terraform-aws-s3`
4. Choose the latest version
5. ⚠️ **Remember the tag version** to use in config

📌 **Illustration of finding module by tag:**  
![Tag-module](/images/module-tag.png)

#### **Step 3: Determine Module Path**
Modules are structured as:
```
modules/
└── aws/
    └── service_name/
```
Example with S3 module:
```
modules/
└── aws/
    └── s3/
```

📌 **Illustration of module folder:**  
![module-name](/images/module-name.png)

#### **Step 4: Check Required Variables**
1. Open the `_variables.tf` file in the module folder
2. Review required and optional variables
3. Check the `examples/` folder to understand usage

#### **Step 5: Use Module in Code**
Standard format:
```hcl
module "module_name" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/<service>?ref=<tag>"
  
  # Module variables
}
```

</details>

#### **Module Source Format:**
```
source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//[MODULE_PATH]?ref=[MODULE_TAG_VERSION]"
```

**Example correct source format:**
```hcl
source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/s3?ref=terraform-aws-s3_v0.2.1"
```

### 8.3 Real example using module to create S3 bucket

Steps similar to **VPC deployment** in section 6.2: **Create config file** → **Plan** → **Apply**.

<details>
<summary>📋 <strong>Details on how to create S3 bucket</strong></summary>

#### Step 1: Create new file named s3.tf

1. Open VS Code or any text editor
2. Create new file: `terraform/envs/dev/1.general/s3.tf`
3. Copy the content below into the file

**File content:**

```hcl
###################
# S3 bucket for storing logs
###################
module "s3_logs" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/s3?ref=terraform-aws-s3_v0.2.1"

  # Basic variables
  project = var.project
  env     = var.env

  # S3 specific configuration
  s3_bucket = {
    name = "${var.project}-${var.env}-logs"
  }
}

###################
# S3 bucket for static website
###################
module "s3_website" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/s3?ref=terraform-aws-s3_v0.2.1"

  project = var.project
  env     = var.env

  s3_bucket = {
    name = "${var.project}-${var.env}-website"
    
    # Enable static website hosting
    website = {
      index_document = "index.html"
      error_document = "error.html"
    }
  }
}
```

#### Step 2: Add outputs

1. Open file: `terraform/envs/dev/1.general/_outputs.tf`
2. Add the content below to the end of the file

**Content to add to end of file:**

```hcl
# Add to end of file
output "s3_logs_bucket_name" {
  value       = module.s3_logs.bucket_name
  description = "Name of S3 logs bucket"
}

output "s3_website_bucket_name" {
  value       = module.s3_website.bucket_name
  description = "Name of S3 website bucket"
}

output "s3_website_url" {
  value       = module.s3_website.website_endpoint
  description = "URL of S3 website"
}
```

#### Step 3: Deploy
```bash
make plan e=dev s=general
make apply e=dev s=general
```

</details>

### 8.4 Using outputs from other services

When you want to use resources from other services (example: using VPC ID from `1.general` in `3.database`), you need to:

#### Step 1: Create new service directory
1. Create directory `terraform/envs/dev/3.database/`
2. Copy `_backend.tf` file from `1.general` to `3.database`

#### Step 2: Update `_backend.tf` in new service
1. Open file: `terraform/envs/dev/3.database/_backend.tf`
2. Change `key` in backend config:

```hcl
terraform {
  backend "s3" {
    profile        = "myproject-dev"
    bucket         = "myproject-dev-iac-state"
    key            = "3.database/terraform.dev.tfstate"  # ← Change path
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:123456789012:key/abc-def-ghi"
    dynamodb_table = "myproject-dev-terraform-state-lock"
  }
}

provider "aws" {
  region  = var.region
  profile = "${var.project}-${var.env}"
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.env
    }
  }
}

# ← Add this section to the end of _backend.tf
data "terraform_remote_state" "general" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "1.general/terraform.${var.env}.tfstate"  # ← Point to general state
    region  = var.region
  }
}
```
Similarly, if you want to use resources from `2.admin` service in `3.database`, add the data "terraform_remote_state" "admin" section to the end of the `_backend.tf` file:
```hcl

data "terraform_remote_state" "admin" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "2.admin/terraform.${var.env}.tfstate"  # ← Point to admin state
    region  = var.region
  }
}
```

#### Step 3: Create symlink for variables
```bash
make symlink e=dev s=database  # ← Use service name: database (without number)
```

#### Step 4: Use outputs in terraform files
Create file `terraform/envs/dev/3.database/rds.tf`:

```hcl
module "database" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/rds?ref=terraform-aws-rds_v0.1.0"

  project = var.project
  env     = var.env

  # ← Use VPC ID from general service
  vpc_id     = data.terraform_remote_state.general.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.general.outputs.private_subnet_ids
}
```

#### Step 5: Deploy new service
```bash
make init e=dev s=database
make plan e=dev s=database
make apply e=dev s=database
```

**💡 Important notes:**
- The `data "terraform_remote_state"` section is declared in the `_backend.tf` file, not in a separate `_data.tf` file
- Each service will have different `key` in backend config to avoid conflicts
- Must deploy service `1.general` before deploying `3.database`
- Current template has: `1.general`, `2.admin` → Create additional `3.database`


### 8.5 Example of using _data.tf
The `_data.tf` file is used to fetch information about existing resources in AWS without creating new ones.

**Example:** Get a list of Availability Zones (AZs) in the current region.

1.  Open file: `terraform/envs/dev/1.general/_data.tf`
2.  Add the following content:

```hcl
# Get information about all available Availability Zones in the current region
data "aws_availability_zones" "available" {
  state = "available"
}
```

3.  Now, you can use this list of AZs in other files, for example, in `vpc.tf`:

```hcl
# example in vpc.tf
resource "aws_subnet" "public" {
  count = 2 # Create 2 public subnets

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  # ... other configurations
}
```

### 8.6 Best practices when using modules

<details>
<summary>📋 <strong>Best Practices for Module Usage Details</strong></summary>

#### **1. Version Control**
- ✅ **Always specify module version** using tags
- ✅ **Use semantic versioning** (v0.1.0, v0.2.0, etc.)
- ✅ **Document module versions** in code
- ❌ **Don't use branches** instead of tags

```hcl
# ✅ CORRECT - Use tag version
source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/s3?ref=terraform-aws-s3_v0.2.1"

# ❌ WRONG - Don't use branch
source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/s3?ref=main"
```

#### **2. Variable Management**
- ✅ **Consistent naming convention** across modules
- ✅ **Document all required variables**
- ✅ **Provide default values** for optional variables
- ✅ **Validate inputs** when possible

#### **3. Module Organization**
- ✅ **Group related resources** in the same module
- ✅ **Keep modules focused** on specific services
- ✅ **Use clear and descriptive names**
- ✅ **Separate concerns** - one module one responsibility

#### **4. Testing & Validation**
- ✅ **Test modules before using in production**
- ✅ **Review module documentation**
- ✅ **Ensure compatibility** with current environment
- ✅ **Check for known issues** or limitations

</details>

---

## 9. 🔧 Writing Your Own Modules

### 9.1 When should you write your own modules?

**✅ When to create your own modules:**
- No existing modules for your specific use case
- Need custom business logic
- Want to combine multiple resources with specific configurations
- Need to enforce company standards and policies

**❌ When not to create modules:**
- There are already good existing modules available
- Only creating 1-2 simple resources
- Configuration is one-time use only

### 9.2 Creating module folder structure

**Step 1: Create modules folder**
1. Open File Manager/Explorer
2. Go to the `terraform` directory of your project
3. Create a new folder named `modules`

**Step 2: Create folder for CodeCommit module**
1. Enter the `modules` folder you just created
2. Create a new folder named `codecommit`
3. Enter the `codecommit` folder

**The resulting structure will be:**
```
terraform/
├── envs/
│   ├── dev/
│   ├── stg/
│   └── prod/
└── modules/          # ← Newly created folder
    └── codecommit/   # ← Folder for CodeCommit module
        └── (will create files in next steps)
```

### 9.3 Module structure

**Standard module structure:**
```
terraform/modules/codecommit/
├── main.tf              # Main resources
├── variables.tf         # Input variables  
├── outputs.tf           # Output values
├── versions.tf          # Provider requirements
└── README.md           # Documentation
```

| 📁 File | 🎯 Purpose | 📝 Main Content |
|---------|-------------|-------------------|
| **main.tf** | Create AWS resources | CodeCommit repos, KMS keys, CloudWatch events |
| **variables.tf** | Define inputs | project, env, repositories config |
| **outputs.tf** | Return information | Repository ARNs, URLs, KMS key IDs |
| **versions.tf** | Provider requirements | Terraform & AWS provider versions |
| **README.md** | Documentation | Usage examples, requirements |

### 9.4 Example: Creating a CodeCommit module

<details>
<summary>📋 <strong>Complete CodeCommit module example</strong></summary>

#### **Input Variables**

**File: `terraform/modules/codecommit/_variables.tf`**

```hcl
variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment (dev/stg/prod)"
  type        = string
}

variable "repositories" {
  description = "Map of CodeCommit repositories to create"
  type = map(object({
    description           = string
    default_branch       = optional(string, "main")
    enable_notifications = optional(bool, false)
    tags                 = optional(map(string), {})
  }))
  
  validation {
    condition = alltrue([
      for repo_name, repo in var.repositories : length(repo.description) > 0
    ])
    error_message = "All repositories must have a non-empty description."
  }
}

variable "enable_kms_encryption" {
  description = "Enable KMS encryption for repositories"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID to use for encryption (if not provided, creates a new key)"
  type        = string
  default     = null
}
```

#### **Main Resources**

**File: `terraform/modules/codecommit/main.tf`**

```hcl
locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    Module      = "codecommit"
    CreatedBy   = "terraform"
  }
  
  name_prefix = "${var.project}-${var.env}"
}

# KMS key for repository encryption
resource "aws_kms_key" "codecommit" {
  count = var.enable_kms_encryption && var.kms_key_id == null ? 1 : 0
  
  description             = "KMS key for ${var.project}-${var.env} CodeCommit repositories"
  deletion_window_in_days = 7
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-codecommit-kms"
  })
}

resource "aws_kms_alias" "codecommit" {
  count = var.enable_kms_encryption && var.kms_key_id == null ? 1 : 0
  
  name          = "alias/${local.name_prefix}-codecommit"
  target_key_id = aws_kms_key.codecommit[0].key_id
}

# CodeCommit repositories
resource "aws_codecommit_repository" "repos" {
  for_each = var.repositories

  repository_name   = "${local.name_prefix}-${each.key}"
  description      = each.value.description
  default_branch   = each.value.default_branch
  
  # KMS encryption
  kms_key_id = var.enable_kms_encryption ? (
    var.kms_key_id != null ? var.kms_key_id : aws_kms_key.codecommit[0].key_id
  ) : null

  tags = merge(local.common_tags, each.value.tags, {
    Name = "${local.name_prefix}-${each.key}"
  })
}

# SNS topic for notifications
resource "aws_sns_topic" "codecommit_notifications" {
  count = length([for repo in var.repositories : repo if repo.enable_notifications]) > 0 ? 1 : 0
  
  name = "${local.name_prefix}-codecommit-notifications"
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-codecommit-notifications"
  })
}

# CloudWatch event rule for CodeCommit events
resource "aws_cloudwatch_event_rule" "codecommit_events" {
  for_each = {
    for repo_name, repo in var.repositories : repo_name => repo
    if repo.enable_notifications
  }

  name        = "${local.name_prefix}-codecommit-${each.key}-events"
  description = "Capture CodeCommit events for ${local.name_prefix}-${each.key}"

  event_pattern = jsonencode({
    source      = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources   = [aws_codecommit_repository.repos[each.key].arn]
  })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-codecommit-${each.key}-events"
  })
}

# CloudWatch event target to SNS
resource "aws_cloudwatch_event_target" "sns" {
  for_each = {
    for repo_name, repo in var.repositories : repo_name => repo
    if repo.enable_notifications
  }

  rule      = aws_cloudwatch_event_rule.codecommit_events[each.key].name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.codecommit_notifications[0].arn
}

# SNS topic policy
resource "aws_sns_topic_policy" "codecommit_notifications" {
  count = length([for repo in var.repositories : repo if repo.enable_notifications]) > 0 ? 1 : 0
  
  arn = aws_sns_topic.codecommit_notifications[0].arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.codecommit_notifications[0].arn
      }
    ]
  })
}
```

#### **Output Values**

**File: `terraform/modules/codecommit/_outputs.tf`**

```hcl
output "repository_arns" {
  description = "ARNs of created CodeCommit repositories"
  value = {
    for repo_name, repo in aws_codecommit_repository.repos : repo_name => repo.arn
  }
}

output "repository_urls" {
  description = "Clone URLs for CodeCommit repositories"
  value = {
    for repo_name, repo in aws_codecommit_repository.repos : repo_name => {
      clone_url_http = repo.clone_url_http
      clone_url_ssh  = repo.clone_url_ssh
    }
  }
}

output "repository_names" {
  description = "Names of created CodeCommit repositories"
  value = {
    for repo_name, repo in aws_codecommit_repository.repos : repo_name => repo.repository_name
  }
}

output "kms_key_id" {
  description = "KMS key ID used for repository encryption"
  value = var.enable_kms_encryption ? (var.kms_key_id != null ? var.kms_key_id : aws_kms_key.codecommit[0].key_id) : null
}

output "kms_key_arn" {
  description = "KMS key ARN used for repository encryption"
  value = var.enable_kms_encryption ? (var.kms_key_id != null ? var.kms_key_id : aws_kms_key.codecommit[0].arn) : null
}
```

#### **Provider Requirements**

**File: `terraform/modules/codecommit/versions.tf`**

```hcl
terraform {
  required_version = ">= 1.3.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
```

</details>

### 9.5 Using your custom module

<details>
<summary>📋 <strong>Example using CodeCommit module</strong></summary>

**File: `terraform/envs/dev/4.deployment/codecommit.tf`**

```hcl
module "codecommit_repos" {
  source = "../../modules/codecommit"

  project = var.project
  env     = var.env

  repositories = {
    frontend = {
      description           = "Frontend application source code"
      enable_notifications = true
      tags = { Application = "frontend", Team = "development" }
    }
    backend = {
      description           = "Backend API source code"
      default_branch       = "develop"
      enable_notifications = true
      tags = { Application = "backend", Team = "development" }
    }
    infrastructure = {
      description           = "Terraform infrastructure code"
      enable_notifications = false
      tags = { Application = "infrastructure", Team = "devops" }
    }
  }

  enable_kms_encryption = true
}
```

**File: `terraform/envs/dev/4.deployment/_outputs.tf`**

```hcl
output "codecommit_repository_arns" {
  description = "ARNs of all CodeCommit repositories"
  value       = module.codecommit_repos.repository_arns
}

output "codecommit_clone_urls" {
  description = "Clone URLs for all repositories"
  value       = module.codecommit_repos.repository_urls
}

output "codecommit_repository_names" {
  description = "Names of all repositories"
  value       = module.codecommit_repos.repository_names
}
```

</details>

### 9.6 Deploy your custom module

<details>
<summary>🚀 <strong>Deployment steps</strong></summary>

```bash
# 1. Create symlink and deploy
make symlink e=dev s=deployment
make init e=dev s=deployment
make plan e=dev s=deployment
make apply e=dev s=deployment
```

**✅ Results after deployment:**
- **3 CodeCommit repositories**: `myproject-dev-frontend`, `myproject-dev-backend`, `myproject-dev-infrastructure`
- **KMS encryption**: Secure source code with AWS KMS
- **CloudWatch events**: Notifications for frontend and backend repos
- **SNS topic**: Send notifications on push/merge events

</details>

### 9.7 Best practices when writing modules

<details>
<summary>📋 <strong>Best Practices for Module Development Details</strong></summary>

**✅ Should do:**

**1. Variable validation**: Validate input values
```hcl
variable "repositories" {
  description = "Map of CodeCommit repositories to create"
  type = map(object({
    description           = string
    default_branch       = optional(string, "main")
    enable_notifications = optional(bool, false)
  }))
  
  validation {
    condition = alltrue([
      for repo_name, repo in var.repositories : length(repo.description) > 0
    ])
    error_message = "All repositories must have a non-empty description."
  }
}
```

**2. Conditional resources**: Create resources conditionally
```hcl
resource "aws_kms_key" "codecommit" {
  count = var.enable_kms_encryption && var.kms_key_id == null ? 1 : 0
  
  description             = "KMS key for ${var.project}-${var.env} CodeCommit repositories"
  deletion_window_in_days = 7
}
```

**3. For_each for multiple instances**: Use for_each instead of count
```hcl
resource "aws_codecommit_repository" "repos" {
  for_each = var.repositories

  repository_name = "${var.project}-${var.env}-${each.key}"
  description     = each.value.description
}
```

**4. Local values**: Use locals for computed values
```hcl
locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    Module      = "codecommit"
    CreatedBy   = "terraform"
  }
  
  name_prefix = "${var.project}-${var.env}"
}

resource "aws_codecommit_repository" "repos" {
  for_each = var.repositories

  repository_name = "${local.name_prefix}-${each.key}"
  description     = each.value.description
  
  tags = merge(local.common_tags, each.value.tags)
}
```

**5. Output with meaningful descriptions**
```hcl
output "repository_arns" {
  description = "ARNs of created CodeCommit repositories for IAM policies"
  value = {
    for repo_name, repo in aws_codecommit_repository.repos : repo_name => repo.arn
  }
}
```

**6. Documentation in README.md**
```markdown
# CodeCommit Module

## Usage
\`\`\`hcl
module "codecommit_repos" {
  source = "./modules/codecommit"
  
  project = "myproject"
  env     = "dev"
  
  repositories = {
    frontend = {
      description = "Frontend app"
      enable_notifications = true
    }
  }
}
\`\`\`

## Requirements
| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| aws | >= 4.0 |
```

**❌ Avoid:**
- ❌ **Hardcode values**: `repository_name = "my-hardcoded-repo"`
- ❌ **Too many variables**: Module with >15 variables is hard to maintain
- ❌ **Module too complex**: Should split into smaller modules
- ❌ **No documentation**: Empty README.md or missing documentation
- ❌ **No validation**: Variables are not validated
- ❌ **Using count instead of for_each**: Hard to manage with multiple instances

**🎯 Best Practice Checklist:**
- ✅ Variables have validation
- ✅ Outputs have clear descriptions
- ✅ Use locals for computed values
- ✅ Consistent and customizable tags
- ✅ Complete README.md with examples
- ✅ Versions.tf defines requirements
- ✅ Module can be reused for multiple environments

</details>

---

## 10. 🔧 Advanced: CI/CD with terraform-dependencies

> **⚠️ Note**: This section is for those who are familiar with basic Terraform and want to learn about CI/CD integration.

<details>
<summary>📋 <strong>10.1 Introduction to CI/CD with AWS CodePipeline</strong></summary>

### 10.1.1 Why do we need CI/CD with Terraform?

**Problems with manual deployment:**
- Running terraform from dev machine → inconsistent
- Forgetting to backup state file → data loss
- Multiple people running simultaneously → conflicts
- No deployment history → difficult to debug

**CI/CD Solutions:**
- **Automated**: Automatic build and deploy
- **Consistent**: Consistent deployment environment
- **Traceable**: History of all deployments
- **Safe**: Approval process in place

### 10.1.2 AWS CI/CD Services

| Service | Purpose | Equivalent |
|---------|---------|------------|
| **CodeBuild** | Build and test code | Jenkins, GitHub Actions |
| **CodeDeploy** | Deploy application | Ansible, Capistrano |
| **CodePipeline** | Orchestrate entire flow | GitLab CI, Azure DevOps |

</details>

<details>
<summary>📋 <strong>10.2 Using CodeBuild with buildspec.yml</strong></summary>

### 10.2.1 Prepare buildspec.yml template

1. **Copy template from terraform-dependencies**:
   ```bash
   cp terraform-dependencies/codebuild/buildspec.yml /path/to/your/app/
   ```

2. **Customize for Node.js application**:
   ```yaml
   version: 0.2
   phases:
     install:
       runtime-versions:
         nodejs: 18
       commands:
         - echo "Installing dependencies..."
         - npm install
     pre_build:
       commands:
         - echo "Running linting..."
         - npm run lint
         - echo "Running unit tests..."
         - npm test
     build:
       commands:
         - echo "Building React application..."
         - npm run build
         - echo "Running integration tests..."
         - npm run test:integration
     post_build:
       commands:
         - echo "Build completed successfully"
         - echo "Uploading artifacts..."
   artifacts:
     files:
       - '**/*'
     base-directory: 'build'
     name: frontend-artifacts-$(date +%Y-%m-%d-%H-%M-%S)
   cache:
     paths:
       - 'node_modules/**/*'
   ```

### 10.2.2 Create CodeBuild project with Terraform

```hcl
# File: terraform/envs/dev/4.deployment/codebuild.tf
module "codebuild" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/codebuild?ref=terraform-aws-codebuild_v0.1.0"
  
  project = var.project
  env     = var.env
  
  codebuild_projects = {
    frontend = {
      name         = "${var.project}-${var.env}-frontend-build"
      description  = "Build project for React frontend"
      source_type  = "GITHUB"
      repository   = "https://github.com/your-org/your-frontend-app"
      buildspec    = "buildspec.yml"
      
      environment = {
        compute_type = "BUILD_GENERAL1_SMALL"
        image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
        type         = "LINUX_CONTAINER"
      }
    }
  }
}
```

</details>

<details>
<summary>📋 <strong>10.3 Using CodeDeploy with appspec.yml</strong></summary>

### 10.3.1 Prepare appspec.yml and hooks

1. **Copy templates**:
   ```bash
   cp terraform-dependencies/codedeploy/appspec.yml /path/to/your/app/
   cp -r terraform-dependencies/codedeploy/hooks/ /path/to/your/app/
   ```

2. **Customize appspec.yml**:
   ```yaml
   version: 0.0
   os: linux
   files:
     - source: /
       destination: /var/www/myapp
   permissions:
     - object: /var/www/myapp
       owner: www-data
       group: www-data
       pattern: "**"
       mode: 755
       type:
         - file
         - directory
   hooks:
     BeforeInstall:
       - location: hooks/1.pull-and-config.sh
         runas: root
         timeout: 300
     AfterInstall:
       - location: hooks/2.build-and-deploy.sh
         runas: www-data
         timeout: 600
     ApplicationStart:
       - location: hooks/3.start.sh
         runas: root
         timeout: 300
     ValidateService:
       - location: hooks/4.validate.sh
         runas: root
         timeout: 180
   ```

3. **Customize hook scripts**:
   ```bash
   # hooks/1.pull-and-config.sh
   #!/bin/bash
   set -e
   echo "=== BeforeInstall Phase ==="
   
   # Stop existing services
   sudo systemctl stop nginx || true
   sudo systemctl stop myapp || true
   
   # Backup current deployment
   if [ -d "/var/www/myapp" ]; then
     sudo cp -r /var/www/myapp /var/www/myapp.backup.$(date +%Y%m%d_%H%M%S)
   fi
   
   # Create directory
   sudo mkdir -p /var/www/myapp
   sudo chown www-data:www-data /var/www/myapp
   ```

### 10.3.2 Create CodeDeploy with Terraform

```hcl
# File: terraform/envs/dev/4.deployment/codedeploy.tf
module "codedeploy" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/codedeploy?ref=terraform-aws-codedeploy_v0.1.0"
  
  project = var.project
  env     = var.env
  
  applications = {
    frontend = {
      name             = "${var.project}-${var.env}-frontend"
      compute_platform = "Server"
      
      deployment_groups = {
        production = {
          deployment_group_name = "production-servers"
          service_role_arn     = data.terraform_remote_state.general.outputs.codedeploy_service_role_arn
          
          ec2_tag_filters = [
            {
              key   = "Environment"
              value = var.env
              type  = "KEY_AND_VALUE"
            },
            {
              key   = "Application"
              value = "frontend"
              type  = "KEY_AND_VALUE"
            }
          ]
          
          deployment_config_name = "CodeDeployDefault.AllAtOne"
        }
      }
    }
  }
}
```

</details>

<details>
<summary>📋 <strong>10.4 Create complete CodePipeline</strong></summary>

### 10.4.1 Pipeline Source → Build → Deploy

```hcl
# File: terraform/envs/dev/4.deployment/pipeline.tf
module "pipeline" {
  source = "git@github.com:sun-asterisk-internal/sun-infra-iac.git//modules/aws/codepipeline?ref=terraform-aws-codepipeline_v0.1.0"
  
  project = var.project
  env     = var.env
  
  pipelines = {
    frontend = {
      name = "${var.project}-${var.env}-frontend-pipeline"
      
      # Stage 1: Source
      source_stage = {
        provider      = "GitHub"
        owner         = "your-org"
        repo          = "your-frontend-app"
        branch        = "main"
        oauth_token   = var.github_token  # Store in AWS Secrets Manager
      }
      
      # Stage 2: Build
      build_stage = {
        provider             = "CodeBuild"
        project_name         = module.codebuild.project_names["frontend"]
        input_artifacts      = ["source_output"]
        output_artifacts     = ["build_output"]
      }
      
      # Stage 3: Deploy
      deploy_stage = {
        provider                = "CodeDeploy"
        application_name        = module.codedeploy.application_names["frontend"]
        deployment_group_name   = "production-servers"
        input_artifacts         = ["build_output"]
      }
    }
  }
  
  # S3 bucket for artifacts
  artifacts_bucket = {
    name                = "${var.project}-${var.env}-pipeline-artifacts"
    versioning_enabled  = true
    encryption_enabled  = true
  }
}
```

### 10.4.2 Deploy pipeline

```bash
# Create symlink
make symlink e=dev s=deployment

# Deploy
make init e=dev s=deployment
make plan e=dev s=deployment
make apply e=dev s=deployment
```

### 10.4.3 Results

**🎯 After deployment, you will have:**
- ✅ **CodeBuild project** builds code from GitHub
- ✅ **CodeDeploy application** deploys to EC2 instances
- ✅ **CodePipeline** automatically runs when code is pushed
- ✅ **S3 artifacts bucket** stores build artifacts
- ✅ **IAM roles** with appropriate permissions

**📱 Automated workflow:**
1. Developer pushes code → GitHub
2. Pipeline automatically triggers
3. CodeBuild: Build + test code
4. CodeDeploy: Deploy to servers
5. Validate: Check health

</details>

<details>
<summary>📋 <strong>10.5 Monitoring and Troubleshooting CI/CD</strong></summary>

### 10.5.1 View logs and status

```bash
# View pipeline status
aws codepipeline get-pipeline-state --name myproject-dev-frontend-pipeline

# View build logs
aws codebuild batch-get-builds --ids <build-id>

# View deployment status
aws deploy get-deployment --deployment-id <deployment-id>
```

### 10.5.2 Common errors and solutions

**❌ Build failed - Dependencies error:**
```yaml
# Add cache in buildspec.yml
cache:
  paths:
    - 'node_modules/**/*'
    - '/root/.npm/**/*'
```

**❌ Deploy failed - Permission denied:**
```bash
# Check CodeDeploy agent IAM role
sudo service codedeploy-agent status
sudo tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

**❌ Pipeline stuck - Manual approval:**
```hcl
# Add manual approval stage
approval_stage = {
  name = "ManualApproval"
  action = {
    name     = "Approve"
    category = "Approval"
    provider = "Manual"
    configuration = {
      CustomData = "Please review and approve deployment to production"
    }
  }
}
```

</details>

---

## 11. ⭐ Best Practices and Troubleshooting

### 11.1 Best Practices

#### **1. Naming Convention**
```hcl
# ✅ Should do
resource "aws_instance" "web_server" {
  name = "${var.project}-${var.env}-web-server"
}

# ❌ Should not do
resource "aws_instance" "server" {
  name = "my-server"
}
```

#### **2. Variable Management**
```hcl
# ✅ Add description section
variable "instance_type" {
  description = "EC2 instance type for web servers"
  type        = string
  default     = "t3.micro"
}
```

#### **3. State Management**
- Always use remote backend
- Don't commit state files to git
- Backup state files regularly

#### **4. Security**
- Don't hardcode credentials
- Use IAM roles instead of access keys when possible
- Encrypt sensitive data

#### **5. Documentation**
- Comment code thoroughly
- Update README
- Document outputs and variables

### 11.2 Common Troubleshooting

#### **Error: Access Denied**
```bash
Error: error configuring S3 Backend: NoCredentialsError
```

**Solution:**
1. Check AWS credentials:
   ```bash
   aws sts get-caller-identity --profile myproject-dev
   ```
2. Regenerate MFA token if needed:
   ```bash
   ./create-aws-sts.sh myproject-default myproject-dev <account-id> <username> <token>
   ```

#### **Error: State locked**
```bash
Error: Error locking state: ConditionalCheckFailedException
```

**Solution:**
1. Check who is running Terraform:
   ```bash
   make state_list e=dev s=general
   ```
2. Force unlock (be careful!):
   ```bash
   terraform force-unlock -force <lock-id>
   ```

#### **Error: Module not found**
```bash
Error: Module not installed
```

**Solution:**
```bash
make init_upgrade e=dev s=general
```

#### **Error: Resource already exists**
```bash
Error: resource already exists
```

**Solution - Import resource:**
```bash
make state_import e=dev s=general t='aws_vpc.example' ot='vpc-12345678'
```

### 11.3 Useful Commands

#### **State Management:**
```bash
# View all resources
make state_list e=dev s=general

# View resource details
make state_show e=dev s=general t='module.vpc.aws_vpc.vpc'

# Remove resource from state (doesn't delete actual resource)
make state_rm e=dev s=general t='module.vpc.aws_vpc.vpc'

# Move resource in state
make state_mv e=dev s=general t='module.old_name' ot='module.new_name'
```

#### **Destroy Resources:**
```bash
# Destroy entire service
make destroy e=dev s=general

# Destroy specific resource
make destroy_target e=dev s=general t='module.vpc'

# Plan destroy (preview)
make plan_destroy e=dev s=general
```

---

## 12. 💻 References

### 12.1 Environment Setup
```bash
# Create symlinks for variables
make symlink e=dev s=general           # One service
make symlink_all e=dev                 # All services

# Remove symlinks
make unsymlink e=dev s=general         # One service
make unsymlink_all e=dev               # All services
```

### 12.2 Terraform Operations
```bash
# Initialize
make init e=dev s=general              # Initialize
make init_upgrade e=dev s=general      # Upgrade providers

# Plan & Apply
make plan e=dev s=general              # View changes
make plan_target e=dev s=general t='module.vpc'  # Plan specific resource
make apply e=dev s=general             # Deploy
make apply_target e=dev s=general t='module.vpc' # Apply specific resource

# Multiple services
make plan_all e=dev                    # Plan all services
make apply_all e=dev                   # Apply all services
```

### 12.3 Resource Management
```bash
# Taint (force recreate)
make taint e=dev s=general t='module.vpc.aws_vpc.vpc'
make untaint e=dev s=general t='module.vpc.aws_vpc.vpc'

# State operations
make state_list e=dev s=general
make state_show e=dev s=general t='module.vpc.aws_vpc.vpc'
make state_import e=dev s=general t='module.vpc.aws_vpc.vpc' ot='vpc-12345'
```

### 12.4 Parameters Reference
- **e**: Environment (dev/stg/prod)
- **s**: Service (general/database/deployment/monitoring)
- **t**: Target (module.name or resource)
- **ot**: Other Target (for import/move operations)

---

## 🎯 Conclusion

Congratulations! You have completed the Terraform AWS guide from basic to advanced. Now you can:

✅ **Understand Terraform and AWS basics**  
✅ **Set up development environment**  
✅ **Manage state and backend**  
✅ **Deploy infrastructure**  
✅ **Use modules effectively**  
✅ **Manage multiple environments**  
✅ **Debug and troubleshoot issues**  

### 📚 Reference Documentation
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Documentation](https://docs.aws.amazon.com/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Project Repository](https://github.com/sun-asterisk-internal/sun-infra-iac)

### 🚀 Next Steps
1. **Practice**: Create a real-world project
2. **Learn advanced**: Terraform workspaces, custom modules
3. **DevOps**: Integrate with CI/CD pipeline
4. **Security**: Terraform security best practices
5. **Monitoring**: Set up monitoring and alerting

**Happy Terraforming! 🎉**
