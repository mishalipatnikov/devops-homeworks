### Скриншоты
1. `ansible-lint site.yml`  
![01](./ansible-lint.png)
2. `ansible-playbook -i inventory/prod.yml site.yml --check`  
![02](./ansible-check.png)
3. `ansible-playbook -i inventory/prod.yml site.yml --diff` 
![03](./ansible-diff.png)

### Описание  
1. Тут же добавил папку для терраформа, чтобы руками не создавать ВМ. Создаются отдельный хост под каждое приложение, всего их три.
2. Плейбук устанавливает на хост Clickhouse и создает БД для него, устанавливает Vector и добавляет файл конфигурации из шаблона, скачивает с git Lighthouse
3. В параметрах есть пакеты, которые нужно установить и их версии для RedHat. Изначально версия работали, но в репозитории Ubuntu устанавливается последняя доступная версия
4. В инвентаре надо указать ip адреса хостов, на которые будут устанавливаться Vector, Clickhouse, Lighthouse