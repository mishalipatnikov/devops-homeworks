1. Создал 3 ВМ, один менеджер, два воркера  
На менеджере установил докер и создал swarm  
`docker swarm init`
2. На воркерах выполнил подключение к swarm  
```
sudo apt update -y && \
sudo apt install docker.io -y && \
sudo docker swarm join --token SWMTKN-1-2eab2io75tjr74emjurjqiy86h81vwy51ucgp4f9ezq1boh8yw-a0ozxoh78ocymzo0ab5a0fd8t 10.129.0.33:2377
```
3. Вывод нод  
![swarm](swarm.png)
