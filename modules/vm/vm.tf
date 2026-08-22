resource "proxmox_virtual_environment_vm" "this" {
  name        = var.vm_name
  node_name   = var.node_name
  description = join("\n\n", [var.vm_config.vm_description, "(Managed by OpenTofu)"])
  tags        = var.vm_config.vm_tags
  cpu {
    cores        = var.vm_config.cpu_cores
    sockets      = var.vm_config.cpu_sockets
    architecture = var.vm_config.cpu_architecture
    type         = var.vm_config.cpu_type
  }

  memory {
    dedicated = var.vm_config.memory_size_mb
  }

  disk {
    datastore_id = var.vm_config.disk_datastore_id
    interface    = var.vm_config.disk_interface
    file_id      = var.vm_config.disk_file_id
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.vm_config.ipv4_address
      }
    }

    user_account {
      username = var.vm_config.user_account_username
      password = var.user_account_password
    }
  }


}
