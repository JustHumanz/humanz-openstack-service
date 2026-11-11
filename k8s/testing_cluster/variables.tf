variable "os_cloud" {
  description = "Name of the OpenStack cloud configuration to use"
  type        = string
  default     = "openstack"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "k8s-cluster"
}

variable "cluster_template_id" {
  description = "ID of the cluster template to use"
  type        = string
  # You need to provide this value
}

variable "keypair_name" {
  description = "Name of the SSH keypair to use"
  type        = string
  # You need to provide this value
}

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 1
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "nodegroup_name" {
  description = "Name of the worker nodegroup"
  type        = string
  default     = "worker-pool"
}

variable "master_node_flavor" {
  description = "Flavor of master nodes"
  type        = string
  default     = "m1.medium"
}

variable "worker_node_flavor" {
  description = "Flavor ID of worker nodes for the Magnum nodegroup"
  type        = string
  default     = "m1.medium"
}