output "public_ip" {
   description = "Public IP address of the Jenkins server"
   value = aws_eip.project_jenkins_eip.public_ip
}