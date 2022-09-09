output "web_address" {
  description = "The web address of the Jenkins server"
  value       = aws_route53_record.dns_A_record.name
}