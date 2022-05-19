###################
# For Terraform
###################
#Symlink: When create new service
.PHONY: symlink
symlink:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo "symlink variables.tf for $$service_path" && \
		ln -sfn $(shell pwd)/terraform/environments/$$ENV/variables.tf $(shell pwd)/$$service_path && \
		find $$service_path -type l >> .gitignore; \
		fi \
	done

.PHONY: symlink_all
symlink_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo "symlink variables.tf for $$service" && \
		ln -sfn $(shell pwd)/terraform/environments/$$ENV/variables.tf $(shell pwd)/$$service && \
		find $$service -type l >> .gitignore; \
	done

#Init
.PHONY: init
init:
	@read -p "enter Environment & Service: " ENV SERVICE && \
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo $$service_path && terraform -chdir=$$service_path init; \
		fi \
	done

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
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo $$service_path && terraform -chdir=$$service_path plan --var-file=../terraform.$$ENV.tfvars; \
		fi \
	done

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
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo $$service_path && terraform -chdir=$$service_path plan --var-file=../terraform.$$ENV.tfvars -destroy; \
		fi \
	done

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
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo $$service_path && terraform -chdir=$$service_path apply --var-file=../terraform.$$ENV.tfvars; \
		fi \
	done

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
	service_list=$$(ls -d terraform/environments/$$ENV/*/ | cut -d . -f2 | cut -d / -f1) && \
	for service in $$service_list; do \
        if [ $$service = $$SERVICE ]; then\
		service_path=$$(ls -d terraform/environments/$$ENV/*/ | grep $$SERVICE | head -n 1) && echo $$service_path && terraform -chdir=$$service_path destroy --var-file=../terraform.$$ENV.tfvars; \
		fi \
	done

.PHONY: destroy_all
destroy_all:
	@read -p "enter Environment: " ENV && \
	service_path=$$(ls -d terraform/environments/$$ENV/*/) && \
	for service in $$service_path; do \
		echo $$service && terraform -chdir=$$service destroy --var-file=../terraform.$$ENV.tfvars; \
	done
