# Ubuntu Nginx VM

This Terraform configuration creates an Ubuntu VM with Nginx installed using cloud-init.

## Prerequisites

- OpenStack cloud access configured
- Terraform installed
- SSH keypair created in OpenStack

## Usage

1. Update `terraform.tfvars` with your specific values if needed.
2. Run the following commands:

```bash
terraform init
terraform plan
terraform apply
```

## Variables

- `instance_name`: Name of the VM instance (default: "ubuntu-nginx-vm")
- `image_name`: Ubuntu image name (default: "Ubuntu 22.04")
- `flavor_name`: VM flavor (default: "m1.small")
- `keypair_name`: SSH keypair name (required)
- `network_name`: Network name (default: "public")
- `security_groups`: List of security groups (default: ["default"])

## Outputs

- `instance_id`: ID of the created VM
- `instance_name`: Name of the VM
- `instance_ip`: IP address of the VM
