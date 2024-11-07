locals {
  vm_names = {
    web_vm_name = "${var.vpc_name}-${var.vm_web_name}"
    db_vm_name = "${var.vpc_name}-${var.vm_db_name}"
  }
}