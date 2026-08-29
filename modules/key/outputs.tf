output "key_name" {
  description = "The name of the generated key."
  value       = "${var.key_name}"
}

output "public_key" {
  description = "The public key generated for the virtual machine."
  value       = trimspace(tls_private_key.vm_key.public_key_openssh)
}

output "private_key" {
  description = "The private key generated for the virtual machine."
  value       = tls_private_key.vm_key.private_key_pem
  sensitive   = true
}
