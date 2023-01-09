locals {
  hosts = {
    mini-pve-001 = { ip = "10.10.10.20/24" },
    #mini-pve-002 = { ip = "10.10.10.21/24" },
    #mini-pve-003 = { ip = "10.10.10.22/24" },
  }
}

resource "proxmox_vm_qemu" "cloudinit_test" {
  for_each    = local.hosts
  name        = "test-${each.key}"
  target_node = each.key

  clone      = "debian.qcow2-template"
  full_clone = true
  tablet     = false
  disk {
    type    = "scsi"
    storage = "nvme-${each.key}"
    size    = "10G"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  cores   = 2
  sockets = 1
  memory  = 1024

  ssh_user   = "root"
  os_type    = "cloud-init"
  ciuser     = "root"
  cipassword = "root"
  nameserver = "1.1.1.1"
  ipconfig0  = "ip=${each.value.ip},gw=10.10.10.1"
  sshkeys    = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxmYRVyvWcZgvApd94KWSO+c1vXCRA6RfazlSrASgBp
    EOF
}
