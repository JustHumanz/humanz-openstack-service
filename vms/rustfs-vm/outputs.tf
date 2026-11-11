output "instance_id" {
  description = "ID of the created VM instance"
  value       = openstack_compute_instance_v2.vm.id
}

output "instance_name" {
  description = "Name of the created VM instance"
  value       = openstack_compute_instance_v2.vm.name
}

output "instance_ip" {
  description = "IP address of the VM instance"
  value       = openstack_compute_instance_v2.vm.access_ip_v4
}
