# iac-pve-public
This repository contains public Terraform/OpenTofu modules for use with my personal homelab setup.

# How to Contribute

Please reach out to the email listed on my profile if you wish to help contribute.

# Notes Before Use

Everything here is subject to change. Ensure that you pin the version of the module you're using.

This relies on `bpg/proxmox` - please ensure you've set up your provider accordingly. You can read up on it [here](https://github.com/bpg/terraform-provider-proxmox). Ensure you configure the provider with your credentials.

Sensitive values are stored in the state. Ensure you're storing these securely.

My desired setup involves creating 2 virtual machines per configuration. One holds the data disk, the other runs the operating system. The reason for this is so that you can quickly swap the operating system image (which causes the vm to be destroyed and recreated) without losing data. If you delete the config from list of VMs, you will lose your data.

# How to Use

In your own private repository, you may create a `vms.tf` file with content that looks like the following:

```terraform
module "keys" {
  source = "github.com/Maxxxxz/iac-pve-public/modules/key?ref=v1.0.0"

  for_each = {
    for k, v in local.vms : k => {
      key_name = v.name
    }
  }
  key_name = each.value.key_name
}

module "passwords" {
  source = "github.com/Maxxxxz/iac-pve-public/modules/password?ref=v1.0.0"

  for_each = {
    for k, v in local.vms : k => {
      password_name = v.name
    }
  }
  password_name = each.value.password_name
}

module "vms" {
  source = "github.com/Maxxxxz/iac-pve-public/modules/vm?ref=v1.0.0"

  depends_on = [module.keys, module.passwords]

  for_each = local.vms
  vm_config = each.value.config
  vm_name = each.value.name
  node_name = each.value.nodename
  user_account_public_key  = module.keys[each.key].public_key
  user_account_password    = module.passwords[each.key].password
}

locals {
    vms = {
        debian-test = {
            name = "debian-test"
            nodename = "test"
            config = {
                vm_tags = ["debian_server"]
                vm_description = "Test debian server."
                os_disk = {
                    disk_size_gb = 8
                    disk_interface = "scsi0"
                    disk_import_from = "local:import/your-debian-cloud-image.qcow2"
                    disk_datastore_id = "local-lvm"
                }
                data_disks = [
                    # Data Disk
                    {
                        disk_size_gb = 10
                        disk_interface = "scsi1"
                        disk_datastore_id = "local-lvm"
                    },
                ]
                cpu_sockets = 1
                cpu_type = "host"
                cpu_cores = 2
                user_account_username = "debian"
                network_vlan_id = {vlan id}
                memory_size_mb = {memory}
                ipv4_address = "{ip}/{mask}"
                ipv4_gateway = "{ip}"
            }
        },
        # Add more vms here.
    }
}

```

### Outputs

The following outputs are available:

#### Key

* `key_name` - The name of the generated key.
* `public_key` - The public key generated for the virtual machine.
* `private_key` - The private key generated for the virtual machine.

#### Password

* `password_name` - The name of the generated password.
* `password` - The generated password for the virtual machine.

#### VM

* `vm_id` - The unique identifier of the virtual machine.
* `vm_name` - The name of the virtual machine.
* `node_name` - The name of the node where the virtual machine is deployed.
* `vm_tags` - The tags associated with the virtual machine.
* `ipv4_address` - The IPv4 address of the virtual machine.
* `user_account_username` - The username of the default user account created on the virtual machine.
* `user_account_password` - The password of the default user account created on the virtual machine.
