variable "project_name" {
  description = "The global project name variable"
}

variable "vpc_name" {
  description = "The VPC name for the project"
}

variable "access_ip" {
  description = "Allowed access name address"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "${var.project_name}-allow-ssh"
  network       = var.vpc_name
  direction     = "INGRESS"
  priority      = 65534
  source_ranges = [var.access_ip]
  target_tags   = ["jenkins-instace"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_jenkins" {
  name          = "${var.project_name}-allow-jenkins"
  network       = var.vpc_name
  direction     = "INGRESS"
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}
