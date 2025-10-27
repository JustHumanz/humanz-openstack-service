terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 3.3.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bucket"
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
  cloud = var.os_cloud
}

data "openstack_images_image_v2" "ubuntu" {
  name        = var.image_name
  most_recent = true
}


resource "openstack_compute_instance_v2" "vm" {
  name            = var.instance_name
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = var.security_groups

  metadata = {
    tunnel = "80"
  }

  network {
    name = var.network_name
  }

  user_data = <<-EOF
    #cloud-config
    package_update: true
    packages:
      - nginx
    runcmd:
      - systemctl enable nginx
      - systemctl start nginx
  EOF
}
