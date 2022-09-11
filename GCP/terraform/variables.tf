variable "gcp_region" {
  default = "australia-southeast1"
}

variable "gcp_region_zone" {
  default = "australia-southeast1-a"
}

variable "aws_region" {
  default = "ap-southeast-2"
}

# Enter your gcp project id (NOTE: not project name)
variable "project_id" {
  description = "The GCP project id"
  type        = string
  default     = "jr-p3-jenkins-sep22"
}

# Set your global name for this project (Note: use "-" instead of "_")
variable "project_name_block" {
  description = "The global project name variable"
  type        = string
  default     = "jr-p3"
}

# Choose your compute engine type here
variable "instance_type_block" {
  description = "The instance type for the Jenkins server"
  type        = string
  default     = "n2-standard-4"
}

# Change the access IP variable in the secrets file
variable "access_ip" {
  description = "Allowed access IP address"
  type        = string
  sensitive   = true
}

# Change the account ID variable in the secrets file
variable "account_id" {
  description = "The account ID for google service"
  type        = string
  sensitive   = true
}

variable "ssh_username" {
  description = "The ssh username for google service"
  type        = string
  sensitive   = true
}

# Change the domain name variable in the secrets file
variable "domain_name" {
  description = "Domain name for the public IP"
  type        = string
  sensitive   = true
}

# Change the gcp credential file variable in the secrets file
variable "credential_path" {
  description = "Local path for the gcp credential"
  type        = string
  sensitive   = true
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}
