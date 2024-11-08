
resource "yandex_compute_instance" "each_vm" {
  for_each = {for vm in var.each_vm : vm.vm_name => vm}

  name        = each.value.vm_name
  zone        = var.default_zone
  platform_id = "standard-v3"

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
    fqdn = "${format("%s.%s.internal", each.value.vm_name, var.default_zone)}"
  }
}


