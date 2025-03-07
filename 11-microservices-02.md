
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

Обычно используют самописные реализации API Gateway, которые могут реализовать все указанные требования.
Мы будем использовать связку NGINX+Lua, которая может решить все поставленные задачи.
## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

Для критериев, которые указаны в задании больше всего подходит Kafka, так как хранит данные на диске, масштабируется и легко управляется, имеет высокую пропускную способность, так же нам не нужно знать сколько у нас получателей для отправки сообщений, что удобно при использовании микросервисной архитектуры.

#### Плюсы RabbitMQ
1. Лёгкость разработки. У RabbitMQ есть библиотеки клиента для большинства современных языков и открытый исходный код, чтобы в нём разбираться.

2. Простое администрирование. У RabbitMQ удобная админка, где вы можете в режиме реального времени разбираться с тем, что происходит. Роутинги можно настраивать в процессе, переключая нагрузку и меняя правила обработки.

3. Тонкая настройка. Многие параметры можно менять, чтобы подстроить систему под свои нужды. Особенно это касается очередей.

#### Минусы RabbitMQ
1. Работа при высокой нагрузке. У RabbitMQ есть сложности при горизонтальном масштабировании в кластере. Приходится добавлять настройки кластеризации над очередями, а они сложные и работают плохо. Приходится выбирать, чем пожертвовать — гибкостью или скоростью.

#### Плюсы Kafka

1. Делает всего две вещи: записывает и отдаёт. Если использовать брокер вместе с надкластером ZooKeeper, то можно наладить кластерные трансферы — Kafka долго этого не умел. 
2. Пропускная способность — миллионы сообщений в секунду. Причём её можно эффективно наращивать: добавить датчик в кластер и при переполнении просто создавать новый, настраивая между ними репликацию. Именно поэтому Kafka стал промышленным стандартом.
3. Позволяет перечитывать сообщения. Если мы прочитали сообщение, а потом потеряли изменение в базе, можно откатить офсет назад и прочитать сообщение снова. 
4. Позволяет читать сообщения пачками. Можно запросить сразу 1000 сообщений, что снижает нагрузку на сеть.

#### Минусы Kafka

1. Проблемы с обработкой битых сообщений. В RabbitMQ необработанное сообщение мы заново закидываем в очередь, и оно крутится, пока его не получится обработать. В Kafka для обработки следующего сообщения нам нужно обработать его или пропустить текущее. Битое мы просто потеряем навсегда.
2. Нужно вести учёт последнего прочитанного сообщения, причём для каждого читателя. Потому что данные неизменны, и мы раскидываем не их, а читателей по одному и тому же массиву данных. То есть храним те точки, где они остановились в чтении. Для этого есть несколько решений, но все они, конечно, утяжеляют систему.


#### Плюсы SQS

1. Безопасность. Тщательное шифрование всех сообщений, которые идут в брокера и от брокера.
2. Автоматические бэкапы.
3. Простая прямая отправка имейлов, СМС, http-запросов.
4. Встроенный DLQ. Битые сообщения можно хранить и обрабатывать позже.
5. Интеграция со всеми другими сервисами Amazon. У него тот же тип авторизации, понятная структура, дизайн и SDK.

#### Минусы SQS

1. Vendor lock. Полная зависимость от Amazon. Перейти на другого поставщика, если что-то случится, будет сложно.


