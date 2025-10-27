variable "os_cloud" {
  description = "Name of the OpenStack cloud configuration to use"
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "ubuntu-nginx-vm"
}

variable "image_name" {
  description = "Name of the Ubuntu image to use"
  type        = string
  default     = "Ubuntu 22.04"
}

variable "flavor_name" {
  description = "Flavor of the VM"
  type        = string
  default     = "m1.small"
}

variable "keypair_name" {
  description = "Name of the SSH keypair to use"
  type        = string
  # You need to provide this value
}

variable "network_name" {
  description = "Name of the network to attach the VM to"
  type        = string
  default     = "public"
}

variable "security_groups" {
  description = "List of security groups to attach to the VM"
  type        = list(string)
  default     = ["default"]
}
