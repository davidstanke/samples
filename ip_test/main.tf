variable "project-name" {
  type    = "string"
}

variable "region" {
  type    = "string"
  default = "us-central1-c"
}

locals {
  timestamp = "${timestamp()}"
  timestamp_sanitized = "${replace("${local.timestamp}", "/[-| |T|Z|:]/", "")}"
}

provider "google" {
  project     = "${var.project-name}"
  region      = "${var.region}"
}

// Create a new instance
resource "google_compute_instance" "default" {
  
  name         = "test-${local.timestamp_sanitized}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // An Ephemeral IP will be assigned
    }
  }

  // startup script:
  // use heredoc format b/c terraform doesn't support multi-line strings
  metadata = {
    startup-script = <<-SCRIPT
    sudo apt update -y && sudo apt install nginx -y
    sudo service nginx start    
    SCRIPT
  }
}

output "ip" {
    value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}