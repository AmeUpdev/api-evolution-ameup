resource "google_compute_address" "static_ip" {
  name   = "${var.vm_name}-static-ip"
  region = var.region

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_instance" "api_server" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [
    "api-evolution-server-0"
  ]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"

      size = var.disk_size_gb
      type = "pd-balanced"
    }
  }

  service_account {
    email  = google_service_account.vm.email
    scopes = ["cloud-platform"]
  }

  network_interface {
    subnetwork = google_compute_subnetwork.main.id

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
    ssh-keys       = "ubuntu:${tls_private_key.ssh_key.public_key_openssh}"
  }

  # NOVO: instala o Docker no primeiro boot
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y ca-certificates curl
    curl -fsSL https://get.docker.com | sh
    apt-get install -y docker-compose-plugin
  EOF

  labels = {
    application = "evolution-api-2"
    environment = "staging"
    managed-by  = "terraform"
  }

  depends_on = [
    google_compute_subnetwork.main,
    google_compute_address.static_ip,
    google_service_account.vm
  ]
}

# 1. Gera a chave privada e pública na memória
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Salva o arquivo da chave privada na sua máquina local (onde roda o terraform)
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/key-evolution-gcp.pem"
  file_permission = "0400" # Permissão restrita obrigatória para o SSH funcionar
}