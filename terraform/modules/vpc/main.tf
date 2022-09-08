## Create a Internet Gateway and attach it to a VPC using a Route Table
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
}

variable "project_name" {
  description = "Set global name variable"
}

# Creating the VPC
resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}_vpc"
    Project = "${var.project_name}"
  }
}

# Creating the Internet Gateway
resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "${var.project_name}_igw"
    Project = "${var.project_name}"
  }
}

# Creating the public Route Table
resource "aws_route_table" "project_public_rt" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
}

## Create a public Subnet and attach it with the Route Table
variable "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet"
}

# Data store that holds the available AZs in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating the public Subnet
resource "aws_subnet" "project_subnet" {
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}_subnet"
    Project = "${var.project_name}"
  }
}

# Attaching the public Subnet with public Route Table
resource "aws_route_table_association" "project_assciation" {
  route_table_id = aws_route_table.project_public_rt.id
  subnet_id = aws_subnet.project_subnet.id
}