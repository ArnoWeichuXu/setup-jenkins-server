#!/bin/bash
cd terraform/
terraform init && terraform fmt -recursive && terraform apply --auto-approve