## Create the EC2 Instance with Jenkins installed and attach an Elastic IP and Key Pair to it
variable "security_group" {
  description = "The security groups assigned to the Jenkins server"
}

variable "public_subnet" {
  description = "The public subnet ID assigned to the Jenkins server"
}

variable "instance_type_block" {
  description = "The instance type for the Jenkins server"
}

variable "project_name" {
  description = "The global project name variable"
}

# Import Ubuntu 20.04 image from aws ami
data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Creating an EC2 instance and install Jenkins
resource "aws_instance" "main" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.public_subnet
  instance_type          = var.instance_type_block
  vpc_security_group_ids = [var.security_group]
  key_name               = aws_key_pair.instance_kp.key_name

  tags = {
    Name    = "jenkins_instance"
    Project = "${var.project_name}"
  }
}

# Creating a Key Pair in AWS
resource "aws_key_pair" "instance_kp" {
  key_name   = "${var.project_name}_jenkins_kp"
  public_key = file("${path.root}/.ssh/${var.project_name}_kp.pub")
}

# Creating an Elastic IP
resource "aws_eip" "instance_epi" {
  instance = aws_instance.main.id
  vpc      = true

  tags = {
    Name    = "${var.project_name}_jenkins_eip"
    Project = "${var.project_name}"
  }
}