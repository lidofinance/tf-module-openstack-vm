variable "name" {}
variable "env" {}
variable "network_id" {}
variable "subnet_id" {}
variable "floating_ip_pool" {}
variable "external_ip" {
  default = false
}
variable "machine_type" {
  default = ""
}
variable "boot_disk_size" {
  default = 50
}
variable "boot_disk_type" {
  default = "CEPH_1_perf2"
}
variable "extra_disk_size" {
  default = 0
}
variable "extra_disk_type" {
  default = "CEPH_1_perf2"
}
variable "extra_disk_name" {
  description = "Name of the extra disk"
  default     = ""
}
variable "extra_disk_snapshot" {
  default = ""
}
variable "boot_disk_auto_delete" {
  default = true
}
variable "description" {
  default = ""
}
variable "ssh_key_pair" {
  description = "Name of the SSH key pair to use"
  default     = ""
}
variable "security_groups" {
  type    = list(string)
  default = []
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}
variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = {}
}
variable "backup_enable" {
  default = false
}
variable "image_id" {}

