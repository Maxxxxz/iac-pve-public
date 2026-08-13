variable "pve_api_url" {
  description = "The URL of the Proxmox API endpoint."
  type        = string
}

variable "pve_username" {
  description = "The username for Proxmox authentication."
  type        = string
}

variable "pve_password" {
  description = "The password for Proxmox authentication."
  type        = string
  sensitive   = true
}
