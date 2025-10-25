# Kubernetes Cluster with Terraform and OpenStack Magnum

This directory contains Terraform configuration to create a Kubernetes cluster using OpenStack Magnum.

## Prerequisites

- Terraform installed
- OpenStack credentials configured
- Access to OpenStack Magnum service

## Configuration

1. Update `terraform.tfvars` with your OpenStack resource IDs:
   - `cluster_template_id`: ID of your Magnum cluster template
   - `keypair_name`: Name of your SSH keypair
   - `network_id`: ID of the network to use
   - `subnet_id`: ID of the subnet to use

2. Optionally, update `variables.tf` to customize cluster parameters.

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. To destroy the cluster:
   ```bash
   terraform destroy
   ```

## Outputs

After successful deployment, the following outputs will be available:
- `cluster_id`: ID of the created cluster
- `cluster_name`: Name of the cluster
- `cluster_status`: Current status of the cluster
- `master_addresses`: Addresses of master nodes
- `node_addresses`: Addresses of worker nodes
