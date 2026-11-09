terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "3.4.0"
    }
  }

  backend "s3" {
    bucket = "tfstate"
    key    = "envs/k8s/testing_cluster/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "https://swift.ctl1-humanz.cloud"
    }

    use_path_style = true

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true

    use_lockfile = true
  }
}

provider "openstack" {
  cloud       = var.os_cloud
}

resource "openstack_containerinfra_cluster_v1" "k8s_cluster" {
  name                = var.cluster_name
  cluster_template_id = var.cluster_template_id
  keypair             = var.keypair_name
  master_count        = var.master_count
  node_count          = var.node_count
  flavor              = var.worker_node_flavor
  master_flavor       = var.master_node_flavor
}
