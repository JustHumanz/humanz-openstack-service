terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 3.3.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "tf"
    endpoints = {
      s3 = var.s3_endpoint

    }
    access_key     = var.s3_access_key
    secret_key     = var.s3_secret_key
    region         = "en-us"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
  }
}

provider "openstack" {
  cloud       = "humanz-cloud"
}

resource "openstack_containerinfra_cluster_v1" "k8s_cluster" {
  name                = var.cluster_name
  cluster_template_id = var.cluster_template_id
  keypair             = var.keypair_name
  master_count        = var.master_count
  node_count          = var.node_count
}
