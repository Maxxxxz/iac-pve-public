variable vm_name {
  description = "var.vm_name"
  type = string
  validation {
    condition = length(var.vm_name) > 0
    error_message = "A 'vm_name' must be specified."
  }
}

variable node_name {
  description = "var.node_name"
  type = string
  validation {
    condition = length(var.node_name) > 0
    error_message = "A 'node_name' must be specified."
  }
}

variable vm_description {
  description = "Description of the virtual machine."
  type = string
  default = "Managed by OpenTofu"
}

variable vm_tags {
  description = "Tags to assign to the virtual machine."
  type = list(string)
  default = []
  validation {
    condition = length(var.vm_tags) > 0
    error_message = "At least one tag must be specified in 'vm_tags'."
  }
}

variable cpu_cores {
  description = "var.cpu_cores"
  type = number
  validation {
    condition = var.cpu_cores > 0
    error_message = "The number of 'cpu_cores' must be greater than 0."
  }
}

variable cpu_sockets {
  description = "var.cpu_sockets"
  type = number
  validation {
    condition = var.cpu_sockets > 0
    error_message = "The number of 'cpu_sockets' must be greater than 0."
  }
}

variable cpu_architecture {
  description = "var.cpu_architecture"
  type = string
  default = "x86_64"
}

variable cpu_type {
  description = "The CPU type to use for the virtual machine. 'host' offers the best performance by using host pass-through."
  type = string
  default = "host"
}

variable memory_size_mb {
  description = "The amount of memory to allocate to the virtual machine in MB."
  type = number
  validation {
    condition = var.memory_size_mb > 0
    error_message = "The 'memory_size_mb' must be greater than 0."
  }
}

variable disk_datastore_id {
  description = "var.disk_datastore_id"
}

variable disk_interface {
  description = "var.disk_interface"
}

variable disk_import_from {
  description = "The source of the disk image to import from PVE."
  validation {
    condition = length(var.disk_import_from) > 0
    error_message = "The path in 'disk_import_from' must be specified."
  }
}

variable ipv4_address {
  description = "The IPv4 address to assign to the virtual machine."
  type = string
}

variable user_account_username {
  description = "The username for the default user account to be created on the virtual machine."
  type = string
}

variable user_account_password {
  description = "The password for the default user account to be created on the virtual machine."
  type = string
  sensitive = true
}
