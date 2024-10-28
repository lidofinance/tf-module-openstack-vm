# OpenStack VM Module

This Terraform module deploys a virtual machine (VM) on OpenStack, complete with networking and optional storage configurations. The module includes resources for the VM instance, a port, floating IP, and an extra disk, if specified.

## Features

This module provides the following features:

- **Compute Instance**: Creates an OpenStack VM with a specified machine type, boot disk configuration, and optional SSH key.
- **Networking**: Attaches a network port with specified security groups to the VM. If configured, it also allocates and associates a floating IP from an external network pool, allowing external access to the VM.
- **Additional Storage**: Adds an optional extra disk to the VM with customizable size, type, and optional snapshot ID.
- **Flexible Metadata**: Supports custom metadata labels.
- **Backup Option for Extra Disk**: Enables optional backup for the additional disk.
- **Lifecycle Management**: Supports boot disk auto-deletion upon VM termination and preserves VM state when redeploying with minimal changes.

## Usage

```hcl
module "sysprom" {
  source           = "git::git@github.com:lidofinance/tf-module-openstack-vm.git?ref=0.0.1"
  name             = "instance-name"
  env              = terraform.workspace
  machine_type     = "a4-ram8-disk50-perf1"
  description      = "Some description of VM"
  image_id         = "image_id"
  network_id       = "network_id"
  subnet_id        = "subnet_id"
  external_ip      = true
  security_groups  = ["secgroup-main", "secgroup-prometheus"]
  labels           = {
    team = "devops",
    env = "mainnet"
  }
  floating_ip_pool = "ext-floating1"
  ssh_key_pair     = "ssh_key_pair_name"
}

```

## Inputs

| Name                  | Description                                                      | Type   | Default | Required |
| --------------------- | ---------------------------------------------------------------- | ------ | ------- | -------- |
| name                  | Name of the instance                                             | string | ""      | no       |
| description           | Description of the VM and its resources.                         | string | n/a     | yes      |
| env                   | Environment label for the resources (e.g., "production", "dev"). | string | n/a     | yes      |
| network_id            | ID of the OpenStack network.                                     | string | n/a     | yes      |
| subnet_id             | ID of the OpenStack subnet.                                      | string | n/a     | yes      |
| security_groups       | List of security groups to associate with the VM's port.         | list   | n/a     | yes      |
| floating_ip_pool      | Pool from which the floating IP will be allocated.               | string | n/a     | no       |
| machine_type          | Flavor or type of the VM instance.                               | string | n/a     | yes      |
| ssh_key_pair          | SSH key pair to associate with the VM for access.                | string | n/a     | yes      |
| image_id              | Image ID to use for the VM's boot disk.                          | string | n/a     | yes      |
| boot_disk_size        | Size of the boot disk in GB.                                     | number | 20      | no       |
| boot_disk_auto_delete | Whether to delete the boot disk upon VM deletion.                | bool   | n/a     | no       |
| extra_disk_size       | Size of the optional extra disk.                                 | number | 0       | no       |
| extra_disk_type       | Type of the optional extra disk.                                 | string | ""      | no       |
| extra_disk_snapshot   | Snapshot ID for the optional extra disk.                         | string | ""      | no       |
| extra_disk_name       | Name of the optional extra disk.                                 | string | ""      | no       |
| labels                | Additional metadata labels for the VM and extra disk.            | map    | {}      | no       |
| backup_enable         | Whether to enable backups for the extra disk.                    | bool   | "false" | no       |
| external_ip           | Whether to allocate and associate a floating IP to the VM.       | bool   | "false" | no       |

## Outputs

| Name   | Description                     |
| ------ | ------------------------------- |
| vm_id  | ID of the created VM instance.  |
| vm_ip  | Internal IP address of the VM.  |
| ext_ip | Floating IP assigned to the VM. |
