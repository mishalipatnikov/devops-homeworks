###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "private_group" {
  type        = string
}


variable "vm_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "vm_web_name" {
  type        = string
  default     = "count-vm-web"
  description = "vm name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image name"
}

variable "alone_vm_name" {
  type        = string
  default     = "alone-vm"
  description = "vm name"
}


variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
    core_fraction = number
  }))
  description = "List of VM configurations"
}




###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqYb3WwAFYlgvmueyVEi6KKjcvIbB2ibd//lxZjzDzu misha@DESKTOP-3GOD4U8"
  description = "ssh-keygen -t ed25519"
}