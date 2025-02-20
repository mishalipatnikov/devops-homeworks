###cloud vars


variable "cloud_id" {
  type        = string
  description = "b1gkd6jtmac58a4pdvit"

}

variable "folder_id" {
  type        = string
  description = "b1gficickhl08apn3u36"
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
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image name"
}



variable "vm_web_name" {
  type        = string
  default     = "monitoring"
  description = "vm name"
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



###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqYb3WwAFYlgvmueyVEi6KKjcvIbB2ibd//lxZjzDzu misha@DESKTOP-3GOD4U8"
  description = "ssh-keygen -t ed25519"
}
