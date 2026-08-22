resource "proxmox_virtual_environment_vm" "this" {
    name = var.vm_name
    node_name = var.node_name
    description = join("\n\n", [var.vm_description, "(Managed by OpenTofu)"])
    tags = var.vm_tags
    cpu {
        cores = var.cpu_cores
        sockets = var.cpu_sockets
        architecture = var.cpu_architecture
        type = var.cpu_type
    }

    memory {
        dedicated = var.memory_size_mb
    }

    disk {
        datastore_id = var.disk_datastore_id
        interface = var.disk_interface
        import_from = var.disk_import_from
    }

    initialization {
        ip_config {
            ipv4 {
                address = var.ipv4_address
            }
        }

        user_account {
            username = var.user_account_username
            password = var.user_account_password
        }
    }


}
