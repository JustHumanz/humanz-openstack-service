output "cluster_id" {
  description = "ID of the created Kubernetes cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.id
}

output "cluster_name" {
  description = "Name of the created Kubernetes cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.name
}

output "cluster_stack_id" {
  description = "Stack id of Kubernetes cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.stack_id
}

output "kube_api" {
  description = "Addresses of the master nodes"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.api_address
}
