# Infrastructure as code (IaC)

 is the process of managing and provisioning of infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools. The definitions may be in a version control system. It can use either scripts or declarative definitions, rather than manual processes

- Benefits:
  - Cost reduction
  - Increase in speed of deployments
  - Reduce errors
  - Improve infrastructure consistency
  - Eliminate configuration drift

![IaC](/images/iac.png)

## IaC Experiences

### Cloud Platform

- [x] AWS
- [ ] Azure
- [ ] GCP

### Operation System (OS)

- [x] Ubuntu
- [ ] CentOS
- [ ] Windows

### Basic Configuration

- [x] Ruby on Rails
- [x] PHP
- [x] Javascripts
- [ ] Python

### Antivirus

- [x] ESET
- [ ] Trendmicro

## IaC Tools

- [**Terraform**](https://github.com/framgia/sun-infra-iac/blob/master/terraform.md)

## How to do

1. Clone this repo, keep only Cloud Provider folder that project using and follow the instructions

- [AWS](/examples/aws/README.md)

**Note**: Remove the remaining Cloud provider folders

2. Choose IaC tools you need to use and follow the instructions

<pre>
├── aws
│   └── <a href="https://github.com/framgia/sun-infra-iac/blob/master/examples/aws/terraform/README.md">terraform</a>
</pre>

**Note**: Remove the remaining IaC tool folders

3. Install dependencies

<details><summary><b>Ubuntu 18.04</b></summary><br>

```bash
sudo apt update
sudo apt install -y unzip software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y python3.7 python3-pip
python3 -m pip install --upgrade pip
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz && tar -xzf terraform-docs.tgz && rm terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
```

</details>

<details><summary><b>Ubuntu 20.04</b></summary><br>

```bash
sudo apt update
sudo apt install -y unzip software-properties-common python3 python3-pip
python3 -m pip install --upgrade pip
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz && tar -xzf terraform-docs.tgz terraform-docs && rm terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
```

</details>

<details><summary><b>MacOS</b></summary><br>

```bash
brew install terraform-docs
brew install tflint
```

</details>

4. Setup pre-commit

```bash
make pre-commit
```

## Contributor

- Do step 1 & 2 in **How to do**

- Before **_add/change/deprecate/remove/fix_** to this branch, please check out new branch like this `feature/<iac-tools>-<cloud-provider>`, example `feature/terraform-aws` and create PR to `master` branch (if you don't have permission to create branch in this repo, please fork this repo) with commit format: _[terraform-aws] Describe your feature/function_

### If you want to create new **terraform modules** to this repo please

- Create new branch like `terraform-aws-<terraform-module>` (if you don't have permission to create branch in this repo, please fork this repo) at `terraform-aws-base` branch. Example:

        ```
        git branch -m terraform-aws-vpc
        git push origin terraform-aws-vpc
        ```

- Checkout new branch `feature/terraform-aws-<terraform-module>` from `terraform-aws-<terraform-module>` and write some code with commit format: _[terraform-aws-"terraform-module"] Describe your feature/function_
- PR to `terraform-aws-<terraform-module>` branch.
- After merged, reviewers need to assign tag and release it

## Release

- **Version**: 1.0 :+1:
- **Date**: 24/12/2021
- **SupportTeam**: [DevOps] IaC & CI/CD :star:
