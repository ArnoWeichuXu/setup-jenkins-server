## Create a Type A record of the public IP in a prerequisite hosted Zone
variable "domain_name" {
  description = "Domain name for the public IP"
}

variable "public_ip" {
  description = "The public IP address of the Jenkins server"
}

# Data stores the prerequisite hosted Zone name
# Change the domain name variable in the secrets file
data "aws_route53_zone" "dns_zone" {
  name = var.domain_name
}

# Creating the Type A record
resource "aws_route53_record" "dns_A_record" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "jenkinsaws.${data.aws_route53_zone.dns_zone.name}"
  type    = "A"
  ttl     = 60
  records = [var.public_ip]
}