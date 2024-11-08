data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "web_count" {
  count = 2
  name        = "${var.vm_web_name}-${count.index+1}"
  platform_id = "standard-v3"
  resources {
  cores         = var.vm_resources.cores
  memory        = var.vm_resources.memory
  core_fraction = var.vm_resources.core_fraction
  }

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
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
    fqdn                 = "${format("%s.%s.internal", var.vm_web_name, var.default_zone)}"
  }

  depends_on = [yandex_compute_instance.each_vm]
}