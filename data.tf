data "openstack_networking_secgroup_v2" "security_groups" {
  for_each = toset(var.security_groups)
  name     = each.key
}

