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

- [x] [AWS](../sun-infra-iac/aws/README.md)
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

- [**Terraform**](../sun-infra-iac/aws/terraform/README.md)

## Master branch

Before **add/change/deprecate/remove/fix** to this branch, please do these steps first

1. Install dependencies

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

2. Excuting pre-commit

```bash
make pre-commit
```

3. Check out new feature like this `feature/iac-aws-terraform`

## Release

- **Version**: 1.0 :+1:
- **Date**: 24/12/2021
- **SupportTeam**: [DevOps] IaC & CI/CD :star:
