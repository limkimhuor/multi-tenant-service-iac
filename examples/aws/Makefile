###################
# For Terraform
###################
#Symlink: When create new service
.PHONY: symlink
symlink:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	ln -sfn $(shell pwd)/terraform/environments/$$ENV/variables.tf $(shell pwd)/terraform/environments/$$ENV/$$SERVICE && \
	find terraform/environments/$$ENV/$$SERVICE -type l >> .gitignore

#Init
.PHONY: init
init:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	terraform -chdir=terraform/environments/$$ENV/$$SERVICE init

.PHONY: init_all
init_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service init; \
	done

#Plan resources
.PHONY: plan
plan:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	terraform -chdir=terraform/environments/$$ENV/$$SERVICE plan --var-file=../terraform.$$ENV.tfvars

.PHONY: plan_all
plan_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service plan --var-file=../terraform.$$ENV.tfvars; \
	done

.PHONY: plan_destroy
plan_destroy:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	terraform -chdir=terraform/environments/$$ENV/$$SERVICE plan --var-file=../terraform.$$ENV.tfvars -destroy

.PHONY: plan_destroy_all
plan_destroy_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service plan --var-file=../terraform.$$ENV.tfvars -destroy; \
	done

#Apply resources
.PHONY: apply
apply:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	terraform -chdir=terraform/environments/$$ENV/$$SERVICE apply --var-file=../terraform.$$ENV.tfvars

.PHONY: apply_all
apply_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service apply --var-file=../terraform.$$ENV.tfvars; \
	done

#Destroy resources
.PHONY: destroy
destroy:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	terraform -chdir=terraform/environments/$$ENV/$$SERVICE destroy --var-file=../terraform.$$ENV.tfvars

.PHONY: destroy_all
destroy_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service destroy --var-file=../terraform.$$ENV.tfvars; \
	done
