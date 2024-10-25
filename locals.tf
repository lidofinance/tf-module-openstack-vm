locals {
  security_group_ids = [for sg in var.security_groups : data.openstack_networking_secgroup_v2.security_groups[sg].id]
}
