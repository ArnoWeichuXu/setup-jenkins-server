output "web_address" {
   description = "Web address of the Jenkins server"
   value = aws_route53_record.project_A_record.name
}