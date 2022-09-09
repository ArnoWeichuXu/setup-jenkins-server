## Create an internet gateway and attach it to a VPC using route table
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
}

variable "project_name" {
  description = "The global project name variable"
}

# Creating the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.project_name}_vpc"
    Project = "${var.project_name}"
  }
}

# Creating the internet gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}_igw"
    Project = "${var.project_name}"
  }
}

# Creating the public route table
resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
}

## Create a public subnet and attach it with the route table
variable "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet"
}

# Data store that holds the available AZs in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating the public subnet
resource "aws_subnet" "vpc_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name    = "${var.project_name}_jenkins_subnet"
    Project = "${var.project_name}"
  }
}

# Attaching the public subnet with public route table
resource "aws_route_table_association" "vpc_rt_association" {
  route_table_id = aws_route_table.vpc_rt.id
  subnet_id      = aws_subnet.vpc_subnet.id
}