locals {
  labels = {
    app = "kittygram"
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_network" "kittygram" {
  name   = var.network_name
  labels = local.labels
}

resource "yandex_vpc_subnet" "kittygram" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.kittygram.id
  v4_cidr_blocks = [var.subnet_cidr]
  labels         = local.labels
}

resource "yandex_vpc_security_group" "kittygram" {
  name        = var.security_group_name
  description = "Allow SSH and Kittygram gateway inbound traffic; allow all outbound traffic."
  network_id  = yandex_vpc_network.kittygram.id
  labels      = local.labels

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = var.ssh_allowed_cidrs
  }

  ingress {
    description    = "Kittygram gateway"
    protocol       = "TCP"
    port           = var.gateway_port
    v4_cidr_blocks = var.gateway_allowed_cidrs
  }

  egress {
    description    = "All outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_storage_bucket" "kittygram" {
  bucket    = var.app_bucket_name
  folder_id = var.folder_id
}

resource "yandex_compute_instance" "kittygram" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = "standard-v3"
  zone        = var.zone
  labels      = local.labels

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram.id]
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "${var.ssh_user}:${var.ssh_public_key}"
    user-data = templatefile("${path.module}/cloud-init.yaml", {
      ssh_user       = var.ssh_user
      ssh_public_key = var.ssh_public_key
    })
  }
}
