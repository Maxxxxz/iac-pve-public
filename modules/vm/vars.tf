variable vm_name {
  description = "var.vm_name"
  type = string
  validation {
    condition     = length(var.vm_name) > 0
    error_message = "A 'vm_name' must be specified."
  }
}

variable node_name {
  description = "var.node_name"
  type = string
  validation {
    condition     = length(var.node_name) > 0
    error_message = "A 'node_name' must be specified."
  }
}

variable user_account_password {
  description = "The password for the default user account to be created on the virtual machine."
  type = string
  sensitive = true
}

variable user_account_public_key {
  description = "The public key for the default user account to be created on the virtual machine."
  type = string
  sensitive = true
}

variable vm_config {
  description = "Configuration for the virtual machine."
  type = object({
    vm_description        = optional(string, "Managed by OpenTofu")
    vm_tags               = list(string)
    cpu_cores             = number
    cpu_sockets           = number
    cpu_architecture      = optional(string, "x86_64")
    cpu_type              = optional(string, "host")
    memory_size_mb        = number
    os_disk               = object({
      disk_size_gb        = number
      disk_datastore_id   = string
      disk_import_from    = string
      disk_interface      = string
    })
    data_disks            = optional(list(object({
      disk_size_gb        = number
      disk_datastore_id   = string
      disk_interface      = string
    })))
    network_vlan_id       = number
    ipv4_address          = string
    ipv4_gateway          = string
    user_account_username = string
  })
  validation {
    condition     = length(var.vm_config.vm_tags) > 0
    error_message = "At least one tag must be specified in 'vm_tags'."
  }
  validation {
    condition     = var.vm_config.cpu_cores > 0
    error_message = "The number of 'cpu_cores' must be greater than 0."
  }
  validation {
    condition     = var.vm_config.cpu_sockets > 0
    error_message = "The number of 'cpu_sockets' must be greater than 0."
  }
  validation {
    condition     = var.vm_config.memory_size_mb > 0
    error_message = "The 'memory_size_mb' must be greater than 0."
  }
  validation {
    condition     = length(var.vm_config.data_disks) > 0
    error_message = "At least one data disk must be specified in 'data_disks'."
  }
  validation {
    condition     = length(var.vm_config.user_account_username) >= 3
    error_message = "The 'user_account_username' must be at least 3 characters long."
  }
}
