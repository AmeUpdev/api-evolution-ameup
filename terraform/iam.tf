# Service account dedicada da VM
resource "google_service_account" "vm" {
  account_id   = "${var.vm_name}-sa"
  display_name = "SA da VM ${var.vm_name}"
}

# Permissões mínimas: só enviar logs e métricas
resource "google_project_iam_member" "vm_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.vm.email}"
}

resource "google_project_iam_member" "vm_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.vm.email}"
}

# OS Login: permite seu usuário fazer SSH como admin (sudo)
resource "google_project_iam_member" "ssh_admin" {
  project = var.project_id
  role    = "roles/compute.osAdminLogin"
  member  = "user:${var.admin_user_email}"
}

# Necessário para usar SSH em uma VM que tem service account anexada
resource "google_service_account_iam_member" "ssh_sa_user" {
  service_account_id = google_service_account.vm.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:${var.admin_user_email}"
}