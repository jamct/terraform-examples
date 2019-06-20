provider "google" {
  credentials = "${file("google.json")}"
  project = "cttest"
  region = "europe-west3"
}

resource "google_compute_address" "server-static" {
  name = "test-ip-address"
}

resource "google_compute_instance" "test2" {
  name = "test-server"
  machine_type = "n1-standard-1"
  zone = "europe-west3-c"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = "curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh"
  metadata {
    ssh-keys = "jam:${file("~/.ssh/id_rsa_CT.pub")}"
  }
  
  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.server-static.address}"
    }
  }
}
