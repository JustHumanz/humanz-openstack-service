variable "os_cloud" {
  description = "Name of the OpenStack cloud configuration to use"
  type        = string
  default     = "openstack"
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "copilot-agent"
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
}

variable "network_name" {
  description = "Name of the network to attach the VM to"
  type        = string
  default     = "public"
}

variable "fixed_ip_v4" {
  description = "Static IPv4 to assign to the VM on the OpenStack network port"
  type        = string
  default     = null
}