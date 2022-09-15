variable "aws_region" {
  default = "ap-southeast-2"
}

# Choose your EC2 type here
variable "instance_type_block" {
  description = "The instance type for the Jenkins server"
  type        = string
  default     = "t2.micro"
}

# Set your global name tag for this project
variable "project_name_block" {
  description = "The global project name variable"
  type        = string
  default     = "my_new_project"
}

# Change the access IP variable in the secrets file
variable "access_ip" {
  description = "Allowed access IP address"
  type        = string
  sensitive   = true
}

# Change the domain name variable in the secrets file
variable "domain_name" {
  description = "Domain name for the public IP"
  type        = string
  sensitive   = true
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}