.PHONY: all validate build plan apply

all: validate build init format plan apply

validate:
	cd packer/assignment-app && packer validate .

build:
	cd packer/assignment-app && packer build .

init:
	cd terraform && terraform_1.4.6 init

format:
	cd terraform && terraform_1.4.6 fmt 
		
plan:
	cd terraform && terraform_1.4.6 plan -out=tfplan

apply:
	cd terraform && terraform_1.4.6 apply -auto-approve tfplan
