output "instance-nat-ip" {
  value = google_compute_instance.jenkins.network_interface.0.access_config.0.nat_ip
}

output "instance-ip" {
  value = google_compute_instance.jenkins.network_interface.0.network_ip
}