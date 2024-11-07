variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image name"
}

variable "vm_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "VM zone"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "vm name"
}



data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_web_image
}



resource "yandex_compute_instance" "platform_db" {
#name        = var.vm_db_name
  name        = local.vm_names.db_vm_name
  zone        = var.vm_zone
  platform_id = "standard-v3"
  resources {
  cores         = var.vm_resources.cores
  memory        = var.vm_resources.memory
  core_fraction = var.vm_resources.core_fraction
  }

 #resources {
#    cores         = 2
#    memory        = 2
#    core_fraction = 20
 # }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

