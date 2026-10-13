resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.network_name}-allow-ssh"
  network = google_compute_network.main.name

  direction = "INGRESS"

  source_ranges = var.ssh_source_ranges

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["api-evolution-server-0"]
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "${var.network_name}-allow-http-https"
  network = google_compute_network.main.name

  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443"
    ]
  }

  target_tags = ["api-evolution-server-0"]
}

resource "google_compute_firewall" "allow_api" {
  name    = "${var.network_name}-allow-api"
  network = google_compute_network.main.name

  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["api-evolution-server-0"]
}