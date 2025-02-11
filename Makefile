infra:
	git pull
	terraform init
	terraform apply -auto-approve -var ssh_username=raghu -var ssh_password=DevOps123456
	## Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time

ansible:
	git pull
	ansible-playbook -i $(tool_name)-internal.azdevopsb82.online, tool-setup.yml -e ansible_user=raghu -e ansible_password=DevOps123456 -e tool_name=$(tool_name) -e vault_token=$(vault_token)
	## Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time




