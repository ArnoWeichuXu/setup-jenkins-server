#!/bin/bash
cd ./terraform
terraform destroy --auto-approve
cd ..
echo "[jenkins]" > ./ansible/host_vars/hosts