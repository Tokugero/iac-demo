locals {
  hosts = {
    mini-pve-001 = { ip = "10.10.10.20/24" },
    mini-pve-002 = { ip = "10.10.10.21/24" },
    mini-pve-003 = { ip = "10.10.10.22/24" },
  }
}

resource "proxmox_vm_qemu" "cloudinit_test" {
  for_each    = local.hosts
  name        = "test-${each.key}"
  target_node = each.key

  cores   = 2
  memory  = 1024
  sockets = 1

  clone      = "debian.qcow2-template"
  full_clone = true
  tablet     = false
  scsihw     = "virtio-scsi-single"

  disk {
    type     = "scsi"
    storage  = "nvme-${each.key}"
    size     = "20G"
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

  cloudinit_cdrom_storage = "nvme-${each.key}"
  os_type                 = "cloud-init"
  ipconfig0               = "ip=${each.value.ip},gw=10.10.10.1"
  sshkeys                 = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp
    EOF

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, world!'",
    ]
  }
}
