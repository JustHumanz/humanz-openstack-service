terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 3.3.0"
    }
  }

  backend "s3" {
    bucket = "tfstate"
    key    = "vms/rustfs-vm/terraform.tfstate"
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

resource "openstack_networking_secgroup_v2" "rustfs_vm" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH and RustFS access to ${var.instance_name}"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.rustfs_vm.id
}

resource "openstack_networking_secgroup_rule_v2" "rustfs" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9000
  port_range_max    = 9000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.rustfs_vm.id
}

resource "openstack_networking_secgroup_rule_v2" "rustfs-admin" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9001
  port_range_max    = 9001
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.rustfs_vm.id
}

resource "openstack_compute_instance_v2" "vm" {
  name            = var.instance_name
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = [openstack_networking_secgroup_v2.rustfs_vm.name]

  network {
    name        = var.network_name
    fixed_ip_v4 = var.fixed_ip_v4
  }

  user_data = <<-EOF
    #cloud-config
    package_update: true
    packages:
      - nfs-common
      - docker.io
      - docker-compose

    write_files:
      - path: /opt/rustfs/docker-compose.yml
        permissions: '0644'
        content: |
          version: "3.9"

          services:
            rustfs_perms:
              image: alpine
              user: root
              volumes:
                - /mnt/rustfs:/data
                - /opt/rustfs/logs:/logs
              command: chown -R 10001:10001 /data /logs

            rustfs:
              image: rustfs/rustfs:alpha
              container_name: rustfs
              depends_on: 
                rustfs_perms:
                  condition: service_completed_successfully
              environment:
                - RUSTFS_CORS_ALLOWED_ORIGINS=*
                - RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS=*
                - RUSTFS_ACCESS_KEY=humanz
                - RUSTFS_SECRET_KEY=${var.rustfs_secret_key}
              ports:
                - "9000:9000"
                - "9001:9001"
              volumes:
                - /mnt/rustfs:/data
                - /opt/rustfs/logs:/logs
              restart: unless-stopped
    runcmd:
      - mkdir -p /mnt/rustfs /opt/rustfs/logs
      - systemctl enable --now docker
      - if ! mountpoint -q /mnt/rustfs; then mount -t nfs 192.168.20.200:/App/rustfs /mnt/rustfs; fi
      - grep -q '192.168.20.200:/App/rustfs /mnt/rustfs nfs defaults,nofail,_netdev 0 0' /etc/fstab || echo '192.168.20.200:/App/rustfs /mnt/rustfs nfs defaults,nofail,_netdev 0 0' >> /etc/fstab
      - docker-compose -f /opt/rustfs/docker-compose.yml up -d
  EOF
}
