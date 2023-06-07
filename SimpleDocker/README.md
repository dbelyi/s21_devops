# DO5_SimpleDocker

## Part 1. Готовый докер

- Взять официальный докер образ с **nginx** и выкачать его при помощи `docker pull`
  
![Untitled](img/1.png) 

- Проверить наличие докер образа через `docker images`

![Untitled](img/2.png) 

- Запустить докер образ через `docker run -d [image_id|repository]`

![Untitled](img/3.png) 

- Проверить, что образ запустился через `docker ps`

![Untitled](img/4.png) 

- Посмотреть информацию о контейнере через `docker inspect [container_id|container_name]`

![Untitled](img/5.png) 

- Размер контейнера. Значение 67108864 представляет собой размер сегмента общей памяти в байтах, что составляет 64 мегабайта. Это означает, что контейнер настроен так, чтобы его процессы могли использовать 64 МБ общей памяти для межпроцессного взаимодействия.

![Untitled](img/6.png)

- Список замапленных портов

![Untitled](img/7.png)

- IP контейнера

![Untitled](img/8.png)

- Остановить докер образ через `docker stop [container_id|container_name]`

![Untitled](img/9.png)

- Проверить, что образ остановился через `docker ps`

![Untitled](img/10.png)

- Запустить докер с замапленными портами 80 и 443 на локальную машину через команду *run*

![Untitled](img/11.png)

- Проверить, что в браузере по адресу *localhost:80* доступна стартовая страница **nginx**

![Untitled](img/12.png)

- Перезапустить докер контейнер через `docker restart [container_id|container_name]`

![Untitled](img/13.png)

- Проверить любым способом, что контейнер запустился

![Untitled](img/14.png)

## Part 2. Операции с контейнером

- Прочитать конфигурационный файл *nginx.conf* внутри докер контейнера через команду *exec*

![Untitled](img/15.png)
  
- Создать на локальной машине файл *nginx.conf.* Настроить в нем по пути */status* отдачу страницы статуса сервера nginx

![Untitled](img/16.png)

- Скопировать созданный файл *nginx.conf* внутрь докер образа через команду `docker cp`

![Untitled](img/17.png)

- Содержимое файла

![Untitled](img/18.png)

- Перезапустить nginx внутри докер образа через команду *exec*

![Untitled](img/19.png)

- Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера nginx

![Untitled](img/20.png)

- Экспортировать контейнер в файл *container.tar* через команду *export.* Остановить контейнер. Удалить образ через `docker rmi [image_id|repository]`, не удаляя перед этим контейнеры. Удалить остановленный контейнер.

![Untitled](img/21.png)

- Импортировать контейнер обратно через команду *import.* Запустить импортированный контейнер]

![Untitled](img/22.png)

- Импорт контейнера

![Untitled](img/23.png)

- Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера nginx

![Untitled](img/24.png)

## Part 4. Свой докер

![Untitled](img/25.png)

- Все также работает

![Untitled](img/26.png)

- Отображение статуса

## Part 5. Dockle

![Untitled](img/27.png)

- Ошибок и предупреждений нет

## Part 6. Базовый Docker Compose

![Untitled](img/28.png)

- Цепочка контейнеров также поднимает nginx

![Untitled](img/29.png)