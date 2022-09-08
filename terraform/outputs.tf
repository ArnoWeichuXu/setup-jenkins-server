output "public_ip" {
   description = "Public IP of the Jenkins server"
   value = module.ec2_instance.public_ip
   sensitive = true
}