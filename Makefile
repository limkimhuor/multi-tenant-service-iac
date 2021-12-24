PRECOMMIT_VERSION := "2.16.0"
# "=" will be executed every time you use this variable
# ":=" will be executed once.


###################
# For Git
###################
.PHONY: pre-commit
pre-commit:
	wget -O pre-commit.pyz https://github.com/pre-commit/pre-commit/releases/download/v${PRECOMMIT_VERSION}/pre-commit-${PRECOMMIT_VERSION}.pyz
	python3 pre-commit.pyz install
	python3 pre-commit.pyz install --hook-type commit-msg
	rm pre-commit.pyz


###################
# For Terraform
###################
#Init
.PHONY: init
init:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	cd aws/terraform/environments/$$ENV/$$SERVICE && terraform init

#Plan/Deploy all resources
.PHONY: plan
plan:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	cd aws/terraform/environments/$$ENV/$$SERVICE && terraform plan --var-file=../terraform.tfvars

.PHONY: apply
apply:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	cd aws/terraform/environments/$$ENV/$$SERVICE && terraform apply --var-file=../terraform.tfvars

#Destroy all resources
.PHONY: plan_destroy
plan_destroy:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	cd aws/terraform/environments/$$ENV/$$SERVICE && terraform plan --var-file=../terraform.tfvars -destroy

.PHONY: destroy
destroy:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	cd aws/terraform/environments/$$ENV/$$SERVICE && terraform destroy --var-file=../terraform.tfvars
