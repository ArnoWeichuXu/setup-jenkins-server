terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }

  required_version = ">= 1.1.5"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                   = "./modules/vpc"
  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  project_name             = var.project_name_block
}

module "security_group" {
  source       = "./modules/security_group"
  vpc_id       = module.vpc.vpc_id
  access_ip    = var.access_ip
  project_name = var.project_name_block
  depends_on = [
    module.vpc
  ]
}

module "instance" {
  source              = "./modules/instance"
  security_group      = module.security_group.security_group_id
  public_subnet       = module.vpc.public_subnet_id
  instance_type_block = var.instance_type_block
  project_name        = var.project_name_block

  depends_on = [
    module.security_group
  ]
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
  public_ip   = module.instance.public_ip

  depends_on = [
    module.instance
  ]
}