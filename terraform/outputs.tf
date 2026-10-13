output "vm_name" {
  description = "Nome da nova VM"
  value       = google_compute_instance.api_server.name
}

output "vm_zone" {
  description = "Zona da VM"
  value       = google_compute_instance.api_server.zone
}

output "static_ip" {
  description = "IP público estático"
  value       = google_compute_address.static_ip.address
}

output "network_name" {
  description = "Nome da VPC"
  value       = google_compute_network.main.name
}

output "subnet_name" {
  description = "Nome da subnet"
  value       = google_compute_subnetwork.main.name
}