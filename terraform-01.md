1. Сменил провайдера в своей директории, создал файл .terraformrc  
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
2. Думаю данные можно хранить в файле о чем намекает комментарий   
 `# own secret vars store.
personal.auto.tfvars`
3. Ключ - `"bcrypt_hash": "$2a$10$7eUdQVUgClWBNhmDQEcA6etPguu8TLq/2tkyraJFaFxeiBr8bhlSq"`  
Значение - `"result": "q7FaTsAmVYM0mFuT"`  
4. На строчке 24 не было указано имя для образа  
На строчке 29 неправильно указано имя с цифры.  
А `random_string_FAKE` мы не объявляли, удалил FAKE и поменял имя атрибута на `result`
5. ```
cat main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~>1.8.4" /*Многострочный комментарий.
 Требуемая версия terraform */
}


provider "docker" {}

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```
6. Опасен тем, что может попасть что-то нежелательное в сборку, либо можем удалить и потерять важные ресурсы  
Полезен для автоматизации, когда роботу не придется ждать от нас согласия.
7. ` keep_locally = true` эта строчка сохранила образ
```
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
```