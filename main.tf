resource "openstack_networking_port_v2" "vm_port" {
  name               = "${var.name}-port"
  network_id         = var.network_id
  admin_state_up     = true
  security_group_ids = local.security_group_ids
  fixed_ip {
    subnet_id = var.subnet_id
  }
}

resource "openstack_networking_floatingip_v2" "ext_ip" {
  count       = var.external_ip ? 1 : 0
  pool        = var.floating_ip_pool
  description = "External IP for ${var.name} in ${var.env} environment"
}

resource "openstack_networking_floatingip_associate_v2" "fip_association" {
  count       = var.external_ip ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.ext_ip[0].address
  port_id     = openstack_networking_port_v2.vm_port.id
}

resource "openstack_blockstorage_volume_v3" "ext_disk" {
  count       = var.extra_disk_size == 0 ? 0 : 1
  name        = var.extra_disk_name == "" ? "${var.name}-extra" : var.extra_disk_name
  size        = var.extra_disk_size
  volume_type = var.extra_disk_type
  snapshot_id = var.extra_disk_snapshot == "" ? null : var.extra_disk_snapshot
  metadata    = { for key, value in merge(var.labels, { description = var.description }, { backup = var.backup_enable }) : key => value }
}

resource "openstack_compute_instance_v2" "vm" {
  name        = var.name
  flavor_name = var.machine_type
  key_pair    = var.ssh_key_pair
  network {
    port = openstack_networking_port_v2.vm_port.id
  }

  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.boot_disk_size
    boot_index            = 0
    delete_on_termination = var.boot_disk_auto_delete
  }

  metadata = { for key, value in merge(var.labels, { description = var.description }) : key => value }

  depends_on = [
    openstack_networking_floatingip_v2.ext_ip,
    openstack_networking_port_v2.vm_port,
    openstack_blockstorage_volume_v3.ext_disk
  ]
  lifecycle {
    ignore_changes = [
      block_device[0].uuid,
    ]
  }
}

resource "openstack_compute_volume_attach_v2" "attached" {
  count       = var.extra_disk_size == 0 ? 0 : 1
  instance_id = openstack_compute_instance_v2.vm.id
  volume_id   = openstack_blockstorage_volume_v3.ext_disk[0].id
  depends_on  = [openstack_compute_instance_v2.vm, openstack_blockstorage_volume_v3.ext_disk[0]]
}
