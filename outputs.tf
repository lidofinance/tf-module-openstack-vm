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
