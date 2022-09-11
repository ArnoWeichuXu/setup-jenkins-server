#Network
variable "project_name" {
  description = "The global project name variable"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for subnet"
}

resource "google_compute_network" "jenkins" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "jenkins" {
  name          = "${var.project_name}-jenkins-subnet"
  ip_cidr_range = var.public_subnet_cidr_block
  network       = google_compute_network.jenkins.name
}
