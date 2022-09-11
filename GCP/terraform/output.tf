output "public_ip" {
  description = "Public IP of the Jenkins server"
  value       = module.instance.instance-nat-ip
}