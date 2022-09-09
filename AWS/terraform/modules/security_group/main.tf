## Create a security group for the EC2 instance
variable "vpc_id" {
  description = "The VPC ID for the project"
  type        = string
}

variable "access_ip" {
  description = "Allowed access IP address"
  type        = string
}

variable "project_name" {
  description = "The global project name variable"
}

# Creating the security group
resource "aws_security_group" "main" {
  description = "Security group for jenkins server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all traffic through port 8080"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NOTE: Change the access IP variable in the secrets file
  ingress {
    description = "Allow SSH from sepcific IP address"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.access_ip}/32"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}_jenkins_sg"
    Project = "${var.project_name}"
  }
}