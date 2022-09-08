#!/bin/bash
# exectute terraform
cd ./terraform
terraform init && terraform apply --auto-approve
echo -e >> ../ansible/host_vars/hosts && echo | terraform output -raw public_ip >> ../ansible/host_vars/hosts

# exectute ansible
cd ../ansible
eval `ssh-agent -s`
ssh-add ../terraform/.ssh/jr_p3_key_pair.pem
ansible-playbook ../ansible/site.yml

# change to original dir
cd ..
