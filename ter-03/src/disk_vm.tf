resource "yandex_compute_disk" "disk_vm" {
  count = 3
  name   = "disk-${count.index + 1}"
  zone   = "ru-central1-a"
  type   = "network-ssd" 
  size   = 20 
}


resource "yandex_compute_instance" "alone_vm" {
  name        = var.alone_vm_name
  zone        = var.default_zone
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk_vm

    content {
      disk_id     = secondary_disk.value.id
      auto_delete = true 
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
    fqdn = "${format("%s.%s.internal", var.alone_vm_name, var.default_zone)}"
  }

}
