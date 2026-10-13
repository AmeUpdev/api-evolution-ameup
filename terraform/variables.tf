variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região da infraestrutura"
  type        = string
  default     = "southamerica-east1"
}

variable "zone" {
  description = "Zona da VM"
  type        = string
  default     = "southamerica-east1-c"
}

variable "vm_name" {
  description = "Nome da VM"
  type        = string
  default     = "api-evolution-server-0"
}

variable "machine_type" {
  description = "Tipo da máquina"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Tamanho do disco da VM"
  type        = number
  default     = 30
}

variable "network_name" {
  description = "Nome da VPC"
  type        = string
  default     = "ameup-network"
}

variable "subnet_name" {
  description = "Nome da subnet"
  type        = string
  default     = "ameup-subnet"
}

variable "subnet_cidr" {
  description = "CIDR da subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "ssh_source_ranges" {
  description = "IPs autorizados a acessar SSH"
  type        = list(string)

  default = [
    "189.121.201.246"
  ]
}
variable "admin_user_email" {
  description = "E-mail do usuário que fará SSH na VM"
  type        = string
}
variable "github_repository" {
  description = "Repositorio GitHub no formato organizacao/repositorio"
  type        = string
}