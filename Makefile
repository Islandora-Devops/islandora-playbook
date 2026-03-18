SHELL := /bin/bash

PLAYBOOK ?= playbook.yml
VAGRANT_INVENTORY ?= inventory/vagrant
REMOTE_INVENTORY ?= .inventory/remote.ini
REMOTE_NAME ?= remote
REMOTE_PORT ?= 22
REMOTE_GROUPS ?= alpaca database webserver tomcat solr crayfish
ISLANDORA_DISTRO ?= ubuntu/jammy64
ISLANDORA_INSTALL_PROFILE ?= starter
ISLANDORA_BUILD_BASE ?= false
VAGRANT_BASE_BOX ?= islandora_base

.PHONY: help deps clean-roles lint build up provision rebuild refresh-base ssh halt destroy
.PHONY: remote-inventory ping deploy bootstrap remote-base
.PHONY: vagrant-base vagrant-up vagrant-provision vagrant-ssh vagrant-halt vagrant-destroy
.PHONY: remote-ping remote-apply remote-bootstrap remote-build-base
.PHONY: demo-objects

help: ## Show this help message
	echo 'Usage: make [target]'
	echo ''
	echo 'Available targets:'
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%s\033[0m\t%s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort | column -t -s $$'\t'

deps: ## Install Ansible roles and collections
	ansible-galaxy role install -r requirements.yml -p roles/external
	ansible-galaxy collection install -r requirements-ci.yml -p collections

clean-roles: ## Remove cached external roles so the next deps run fetches fresh copies
	rm -rf roles/external

lint: ## Run the local lint suite across all files
	./scripts/run-lint --all-files

build: vagrant-base ## Build and import the Vagrant base box (stage 1)

vagrant-base: deps
	bash ./scripts/vagrant-base

up: vagrant-up ## Start and provision Islandora with ISLANDORA_BUILD_BASE=false (stage 2)

vagrant-up: deps vagrant-base
	bash ./scripts/vagrant-up

provision: vagrant-provision ## Re-run stage 2 provisioning on the Vagrant VM

vagrant-provision: deps
	ISLANDORA_BUILD_BASE=false vagrant provision

rebuild: destroy up ## Recreate the VM from the existing cached base box

refresh-base: ## Rebuild and reinstall the cached Vagrant base box from scratch
	vagrant destroy -f
	-vagrant box remove $(VAGRANT_BASE_BOX)
	rm -f $(VAGRANT_BASE_BOX)
	bash ./scripts/vagrant-base

ssh: vagrant-ssh ## SSH into the Vagrant VM

vagrant-ssh:
	vagrant ssh

halt: vagrant-halt ## Stop the Vagrant VM

vagrant-halt:
	vagrant halt

destroy: vagrant-destroy ## Destroy the Vagrant VM

vagrant-destroy:
	vagrant destroy

remote-inventory: ## Generate a remote Ansible inventory from REMOTE_* vars
	@test -n "$(REMOTE_HOST)" || { echo "REMOTE_HOST is required"; exit 2; }
	@test -n "$(REMOTE_USER)" || { echo "REMOTE_USER is required"; exit 2; }
	@mkdir -p $(dir $(REMOTE_INVENTORY))
	@{ \
		printf "[all]\n"; \
		printf "%s ansible_host=%s ansible_user=%s ansible_port=%s" "$(REMOTE_NAME)" "$(REMOTE_HOST)" "$(REMOTE_USER)" "$(REMOTE_PORT)"; \
		if [[ -n "$(REMOTE_KEY)" ]]; then printf " ansible_ssh_private_key_file=%s" "$(REMOTE_KEY)"; fi; \
		printf "\n\n"; \
		for group in $(REMOTE_GROUPS); do \
			printf "[%s]\n%s\n\n" "$$group" "$(REMOTE_NAME)"; \
		done; \
	} > $(REMOTE_INVENTORY)
	@printf "Wrote %s\n" "$(REMOTE_INVENTORY)"

ping: remote-ping ## Ping the remote host with Ansible

remote-ping: remote-inventory
	ansible all -i $(REMOTE_INVENTORY) -m ping

bootstrap: remote-bootstrap ## Bootstrap a remote host for Islandora deployment

remote-bootstrap: deps remote-inventory
	ansible-playbook -i $(REMOTE_INVENTORY) bootstrap.yml \
		-e ansible_user=$(REMOTE_USER) \
		-e islandora_distro=$(ISLANDORA_DISTRO) \
		-e islandora_profile=$(ISLANDORA_INSTALL_PROFILE) \
		-e islandora_build_base_box=$(ISLANDORA_BUILD_BASE)

remote-base: remote-build-base ## Apply stage 1 of the main playbook to a remote host

remote-build-base: deps remote-inventory
	ansible-playbook -i $(REMOTE_INVENTORY) $(PLAYBOOK) \
		-e ansible_user=$(REMOTE_USER) \
		-e islandora_distro=$(ISLANDORA_DISTRO) \
		-e islandora_profile=$(ISLANDORA_INSTALL_PROFILE) \
		-e islandora_build_base_box=true

deploy: remote-apply ## Apply stage 2 of the main playbook to a remote host

remote-apply: deps remote-inventory
	ansible-playbook -i $(REMOTE_INVENTORY) $(PLAYBOOK) \
		-e ansible_user=$(REMOTE_USER) \
		-e islandora_distro=$(ISLANDORA_DISTRO) \
		-e islandora_profile=$(ISLANDORA_INSTALL_PROFILE) \
		-e islandora_build_base_box=false
demo-objects: up ## Add demo objects from https://github.com/Islandora-Devops/islandora_demo_objects
	./scripts/demo-objects.sh
