terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.5.0"
    }
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws]
    }
  }

}

provider "google" {
  credentials = file(var.credential_path)
  project     = var.project_id
  region      = var.gcp_region
  zone        = var.gcp_region_zone
}

provider "aws" {
  region = var.aws_region
}


module "network" {
  source                   = "./modules/network"
  project_name             = var.project_name_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
}

module "instance" {
  source              = "./modules/instance"
  project_name        = var.project_name_block
  account_id          = var.account_id
  instance_type_block = var.instance_type_block
  vpc_name            = module.network.vpc_name
  subnet_name         = module.network.subnet_name
}

module "firewall" {
  source       = "./modules/firewall"
  project_name = var.project_name_block
  vpc_name     = module.network.vpc_name
  access_ip    = var.access_ip
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
  public_ip   = module.instance.instance-nat-ip
}