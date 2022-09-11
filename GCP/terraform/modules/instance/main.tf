# Instance
variable "instance_type_block" {
  description = "The instance type for the Jenkins server"
}

variable "account_id" {
  description = "The account ID for google service"
}

variable "ssh_username" {
  description = "The account ID for google service"
}

variable "project_name" {
  description = "The global project name variable"
}

variable "subnet_name" {
  description = "The public subnet name assigned to the Jenkins server"
}

variable "vpc_name" {
  description = "The VPC name for the project"
}

data "google_service_account" "jenkins" {
  account_id = var.account_id
}

resource "google_compute_instance" "jenkins" {
  name         = "jenkins-instance"
  machine_type = var.instance_type_block
  tags         = ["${var.project_name}", "jenkins-instance"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220905"
      size  = 50
    }
    auto_delete = true
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file("${path.root}/.ssh/${var.project_name}-gcp-kp.pub")}"
  }

  service_account {
    email  = data.google_service_account.jenkins.email
    scopes = ["cloud-platform"]
  }
}

