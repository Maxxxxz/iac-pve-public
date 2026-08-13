terraform {
    required_providers {
        proxmox = {
            source  = "bpg/proxmox"
            version = "0.111.1"
        }
    }
}

provider "proxmox" {
    endpoint = vars.pve_api_url
    username = vars.pve_username
    password = vars.pve_password
    # Local - using self-signed certificate so it's "insecure"
    insecure = true
}
