## Create a Type A record of the public IP in a prerequisite hosted Zone
variable "domain_name" {
   description = "Domain name for the public IP"
}

variable "public_ip" {
  description = "Public IP address of the Jenkins server"
}

# Data stores the prerequisite hosted Zone name
# Change the domain name variable in the secrets file
data "aws_route53_zone" "project_zone" {
  name = var.domain_name
}

# Creating the Type A record
resource "aws_route53_record" "project_A_record" {
  zone_id = data.aws_route53_zone.project_zone.zone_id
  name = "jenkins.${data.aws_route53_zone.project_zone.name}"
  type = "A"
  ttl = 60
  records = [var.public_ip]
}
