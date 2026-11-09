terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.3.0"
    }
  }

  backend "s3" {
    bucket = "tfstate"
    key    = "vms/copilot-agent-vm/terraform.tfstate"
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
  cloud = var.os_cloud
}

data "openstack_images_image_v2" "ubuntu" {
  name        = var.image_name
  most_recent = true
}

resource "openstack_networking_secgroup_v2" "copilot_agent" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH access to ${var.instance_name}"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.copilot_agent.id
}

resource "openstack_compute_instance_v2" "vm" {
  name            = var.instance_name
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = [openstack_networking_secgroup_v2.copilot_agent.name]

  network {
    name        = var.network_name
    fixed_ip_v4 = var.fixed_ip_v4
  }

  user_data = <<-EOF
    #cloud-config
    package_update: true
    packages:
      - ca-certificates
      - curl

    runcmd:
      - [bash, -lc, "curl -fsSL https://gh.io/copilot-install | PREFIX=/usr/local bash"]
  EOF
}