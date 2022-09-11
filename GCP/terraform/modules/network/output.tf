output "subnet_name" {
  description = "The public subnet name assigned to the Jenkins serve"
  value       = google_compute_subnetwork.jenkins.name
}

output "vpc_name" {
  description = "The VPC name for the project"
  value       = google_compute_network.jenkins.name
}