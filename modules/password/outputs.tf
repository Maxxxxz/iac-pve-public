output "password_name" {
  description = "The name of the generated password."
  value       = "${var.password_name}"
}

output "password" {
  description = "The generated password for the virtual machine."
  value       = random_password.vm_password.result
  sensitive   = true
}
