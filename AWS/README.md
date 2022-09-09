# Build up Jenkins Server on EC2
### Before you run the script
##### 1. change the values in `variables.tf` for the following variables
- "instance_type_block"
- "project_name_block"

##### 2. create `secrets.auto.tfvars` under `terrafrom/` , then add:
```
access_ip = <ip address allowed to access the Jenkins server>
domain_name = <domain name registered for the Jenkins server>
```
### Run the script to build up the Jenkins server
```bash
sudo chmod +x build_aws.sh
./build_aws.sh
```
### Run the script to destroy the infrastructure
```bash
sudo chmod +x destroy_aws.sh
./destroy_aws.sh
```