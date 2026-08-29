resource "random_password" "vm_password" {
  length           = var.password_length
  special          = true
  override_special = var.password_special_characters
}
