output "security_group_id" {
  description = "The security groups assigned to the Jenkins server"
  value       = aws_security_group.main.id
}