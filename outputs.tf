output "vm_ext_ip" {
  value = var.external_ip ? openstack_networking_floatingip_v2.ext_ip[0].address : null
}

output "vm_int_ip" {
  value = openstack_compute_instance_v2.vm.network[0].fixed_ip_v4
}

output "vm_name" {
  value = openstack_compute_instance_v2.vm.name
}

output "labels" {
  value = openstack_compute_instance_v2.vm.metadata
}

output "team" {
  value = openstack_compute_instance_v2.vm.metadata["team"]
}

output "additional_disks" {
  description = "Information about the additional disks created and attached to the VM"
  value = {
    volumes = openstack_blockstorage_volume_v3.additional_disks
    attachments = openstack_compute_volume_attach_v2.additional_disks_attached
  }
}

output "all_disk_volumes" {
  description = "All disk volumes (legacy extra disk + additional disks)"
  value = {
    legacy_extra_disk = var.extra_disk_size > 0 ? openstack_blockstorage_volume_v3.ext_disk[0] : null
    additional_disks  = openstack_blockstorage_volume_v3.additional_disks
  }
}
