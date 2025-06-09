variable "name" {
  type = string
}
variable "env" {
  type = string
}
variable "network_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "floating_ip_pool" {
  type = string
}
variable "image_id" {
  type = string
}
variable "external_ip" {
  type    = string
  default = false
}
variable "machine_type" {
  type    = string
  default = ""
}
variable "boot_disk_size" {
  type    = number
  default = 50
}
variable "extra_disk_size" {
  type    = number
  default = 0
}
variable "extra_disk_type" {
  type    = string
  default = "CEPH_1_perf2"
}
variable "extra_disk_name" {
  description = "Name of the extra disk"
  type        = string
  default     = ""
}
variable "extra_disk_snapshot" {
  type    = string
  default = ""
}
variable "extra_disk_enable_online_resize" {
  description = "When this option is set it allows extending attached volumes"
  type        = bool
  default     = true
}
variable "boot_disk_auto_delete" {
  type    = bool
  default = true
}
variable "description" {
  type    = string
  default = ""
}
variable "ssh_key_pair" {
  type        = string
  default     = ""
  description = "Name of the SSH key pair to use"
}
variable "security_groups" {
  type    = list(string)
  default = []
}

variable "labels" {
  description = "Labels to apply to the instance"
  type        = map(string)
  default     = {}
}
variable "backup_enable" {
  type    = bool
  default = false
}
variable "user_data" {
  description = "User data script to pass to the instance."
  type        = string
  default     = null
}
