variable "s3_endpoint" {
  description = "Endpoint URL for the S3-compatible storage"
  type        = string
  default     = "http://127.0.0.1:9090"
}

variable "s3_access_key" {
  description = "Access key for S3-compatible storage"
  type        = string
  default     = ""
}

variable "s3_secret_key" {
  description = "Secret key for S3-compatible storage"
  type        = string
  default     = ""
}

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