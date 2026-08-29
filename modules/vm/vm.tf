resource "proxmox_virtual_environment_vm" "data_vm" {
  name        = join("-", [var.vm_name, "data"])
  tags        = ["data"]
  node_name   = var.node_name
  description = join("\n\n", [var.vm_config.vm_description, "Data VM. Not bootable. (Managed by OpenTofu)"])
  started     = false
  on_boot     = false
  dynamic "disk" {
    for_each = var.vm_config.data_disks
    content {
      size         = disk.value.disk_size_gb
      datastore_id = disk.value.disk_datastore_id
      interface    = disk.value.disk_interface
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
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
  disk {
    size         = var.vm_config.os_disk.disk_size_gb
    datastore_id = var.vm_config.os_disk.disk_datastore_id
    import_from  = var.vm_config.os_disk.disk_import_from
    interface    = var.vm_config.os_disk.disk_interface
  }
  dynamic "disk" {
    for_each = { for idx, val in proxmox_virtual_environment_vm.data_vm.disk : idx => val }
    iterator = data_disk
    content {
      size              = data_disk.value.size
      datastore_id      = data_disk.value.datastore_id
      path_in_datastore = data_disk.value.path_in_datastore
      file_format       = data_disk.value.file_format
      interface         = "scsi${data_disk.key + 1}"
    }
  }

  memory {
    dedicated = var.vm_config.memory_size_mb
  }
  initialization {
    ip_config {
      ipv4 {
        address = var.vm_config.ipv4_address
        gateway = var.vm_config.ipv4_gateway
      }
    }

    user_account {
      username = var.vm_config.user_account_username
      password = var.user_account_password
      keys     = [var.user_account_public_key]
    }
  }

  network_device {
    bridge  = "vmbr0"
    vlan_id = var.vm_config.network_vlan_id
  }

}
