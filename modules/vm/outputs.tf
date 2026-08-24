output "vm_id" {
  description = "The unique identifier of the virtual machine."
  value       = proxmox_virtual_environment_vm.vm.id
}

output "vm_name" {
  description = "The name of the virtual machine."
  value       = proxmox_virtual_environment_vm.vm.name
}

output "node_name" {
  description = "The name of the node where the virtual machine is deployed."
  value       = proxmox_virtual_environment_vm.vm.node_name
}

output "vm_tags" {
  description = "The tags associated with the virtual machine."
  value       = proxmox_virtual_environment_vm.vm.tags
}

output "ipv4_address" {
  description = "The IPv4 address of the virtual machine."
  value       = proxmox_virtual_environment_vm.vm.initialization[0].ip_config[0].ipv4[0].address
}

output "user_account_username" {
  description = "The username of the default user account created on the virtual machine."
  value       = proxmox_virtual_environment_vm.vm.initialization[0].user_account[0].username
}

output "user_account_password" {
  description = "The password of the default user account created on the virtual machine."
  value       = var.user_account_password
  sensitive   = true
}
