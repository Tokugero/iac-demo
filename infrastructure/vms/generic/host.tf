locals {
  hosts = {
    docker-host = { 
      ip = "10.10.10.30/24",
      host = "mini-pve-001",
      memory = 1024*4,
      cores = 2,
      storage_size = "40G",
      storage = "nvme-mini-pve-001"
    },    
    k8s-master-001 = { 
      ip = "10.10.10.31/24",
      host = "mini-pve-001",
      memory = 1024*8,
      cores = 2,
      storage_size = "80G",
      storage = "nvme-mini-pve-001"
    },    
    k8s-worker-001 = { 
      ip = "10.10.10.32/24",
      host = "mini-pve-002",
      memory = 1024*14,
      cores = 3,
      storage_size = "80G",
      storage = "nvme-mini-pve-002"
    },    
    k8s-worker-002 = { 
      ip = "10.10.10.33/24",
      host = "mini-pve-003",
      memory = 1024*14,
      cores = 3,
      storage_size = "80G",
      storage = "nvme-mini-pve-003"
    }
  }
}

resource "proxmox_vm_qemu" "vms" {
  for_each    = local.hosts
  name        = each.key
  target_node = each.value.host

  cores   = each.value.cores
  memory  = each.value.memory
  sockets = 1

  clone      = "debian.qcow2-template"
  full_clone = true
  tablet     = false
  scsihw     = "virtio-scsi-single"

  disk {
    type     = "scsi"
    storage  = each.value.storage
    size     = each.value.storage_size
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  cloudinit_cdrom_storage = each.value.storage
  os_type                 = "cloud-init"
  ipconfig0               = "ip=${each.value.ip},gw=10.10.10.1"
  sshkeys                 = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp
    EOF

  #TODO: Provision with ansible here, bind with declarative and mounted containers
}
