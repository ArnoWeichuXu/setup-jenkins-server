output "public_ip" {
  description = "The public IP address of the Jenkins server"
  value       = aws_eip.instance_epi.public_ip
}