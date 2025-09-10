## Part 1. Готовый докер
+ Возьми официальный докер-образ с nginx и выкачай его при помощи docker pull.
Для начала устанавливаем докер на убунту, для этого используем команду `sudo apt istall docker.io`. Затем вводим команду `sudo docker pull nginx` для установки докер-образа с nginx:
![Alt text](Docker/1.png)
+ Проверь наличие докер-образа через docker images.
![Alt text](Docker/2.png)
+ Запусти докер-образ через docker run -d [image_id|repository].
![Alt text](Docker/3.png)
+ Проверь, что образ запустился через docker ps.
![Alt text](Docker/4.png)
+ Посмотри информацию о контейнере через docker inspect [container_id|container_name].
Используем команду `sudo docker inspect gifted_swartz`:
![Alt text](Docker/5.png)
+ По выводу команды определи и помести в отчёт размер контейнера, список замапленных портов и ip контейнера. Используем команду `sudo docker inspect gifted_swartz --size | grep -i -e Size` для того, чтобы узнать размер и команду `sudo docker inspect gifted_swartz | grep IPAddress`:
![Alt text](Docker/6.png)
![Alt text](Docker/7.png)
Чтобы узнать список замапленных портов, читаем файл gifted_swartz:
![Alt text](Docker/8.png)
+ Останови докер контейнер через docker stop [container_id|container_name].
![Alt text](Docker/9.png)
+ Проверь, что контейнер остановился через docker ps.
![Alt text](Docker/10.png)
+ Запусти докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду run.
![Alt text](Docker/11.png)
+ Проверь, что в браузере по адресу localhost:80 доступна стартовая страница nginx.  

Для начала закрываем виртуальную машину и в настройках в параметре "сеть" делаем проброс портов для nginx:
![Alt text](Docker/12.png)
Только после этого заходим на сайт `localhost:80`:
![Alt text](Docker/13.png)
+ Перезапусти докер контейнер через docker restart [container_id|container_name].
![Alt text](Docker/14.png)
+ Проверь любым способом, что контейнер запустился.
![Alt text](Docker/15.png)

## Part 2. Операции с контейнером
+ Прочитай конфигурационный файл nginx.conf внутри докер контейнера через команду exec.  
Вводим в терминале `sudo docker exec + имя контейнера и команду cat`:
![Alt text](Docker/16.png)
+ Создай на локальной машине файл nginx.conf.  
Создаем в src файл nginx.conf и копируем содержимое файла nginx.conf. 
+ Настрой в нем по пути /status отдачу страницы статуса сервера nginx.  
Дописываем внизу необходимые строчки:
![Alt text](Docker/17.png)
+ Скопируй созданный файл nginx.conf внутрь докер-образа через команду docker cp.
![Alt text](Docker/18.png)
+ Перезапусти nginx внутри докер-образа через команду exec.
![Alt text](Docker/19.png)
+ Проверь, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.  
При открытии cайта:
![Alt text](Docker/20.png)
+ Экспортируй контейнер в файл container.tar через команду export.
+ Останови контейнер.
![Alt text](Docker/21.png)
+ Удали образ через docker rmi [image_id|repository], не удаляя перед этим контейнеры.
![Alt text](Docker/22.png)
+ Удали остановленный контейнер.
![Alt text](Docker/23.png)
+ Импортируй контейнер обратно через команду import.
![Alt text](Docker/24.png)
+ Запусти импортированный контейнер.
![Alt text](Docker/25.png)
+ Проверь, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.
![Alt text](Docker/26.png)

## Part 3. Мини веб-сервер
+ Напиши мини-сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!.  

Для начала устанавливаем необходимую библиотеку fcgi и компилятор через команды `sudo apt-get update` и `sudo apt-get install -y gcc spawn-fcgi libfcgi-dev`. 

Затем создаём в папке src папку server и в ней файл `web-server.c`, после чего пишем наш мини-сервер:
![Alt text](Docker/27.png)

+ Запусти написанный мини-сервер через spawn-fcgi на порту 8080.  
Используем команду `gcc -o server web-server.c -lfcgi`, затем используем `spawn-fcgi -p 8080 ./web_server`:
![Alt text](Docker/28.png)

+ Напиши свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080.
Открываем файл nginx.conf и прописываем:
![Alt text](Docker/29.png)
![Alt text](Docker/30.png)
+ Проверь, что в браузере по localhost:81 отдается написанная тобой страничка.
![Alt text](Docker/37.png)
+ Положи файл nginx.conf по пути ./nginx/nginx.conf (это понадобится позже).

Для перезагрузки используем команду `sudo docker exec -i nostalgic_wiles nginx -s reload`.


Сделала это выше.

## Part 4. Свой докер

+ Напиши свой докер-образ, который:
1) собирает исходники мини сервера на FastCgi из Части 3;
2) запускает его на 8080 порту;
3) копирует внутрь образа написанный ./nginx/nginx.conf;
4) запускает nginx.


Cоздаём файлы в папке src - Dockerfile и obraz.sh:
![Alt text](Docker/40.png)
![Alt text](Docker/34.png)
+ Собери написанный докер-образ через docker build при этом указав имя и тег.
![Alt text](Docker/35.png)
+ Проверь через docker images, что все собралось корректно.
![Alt text](Docker/36.png)
+ Запусти собранный докер-образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а (см. Часть 2).  
Используем команду: `sudo docker run -it --name obraz -p 80:81 -v /Users/lemonkyl/DO5_SimpleDocker-1/src/nginx.conf:/etc/nginx/nginx.conf -d lemonkyl:1.0 bash`
+ Проверь, что по localhost:80 доступна страничка написанного мини сервера.
![Alt text](Docker/38.png)
+ Допиши в ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx.
![Alt text](Docker/41.png)
+ Перезапусти докер-образ.
![Alt text](Docker/42.png)
![Alt text](Docker/42.png)
+ Проверь, что теперь по localhost:80/status отдается страничка со статусом nginx
![Alt text](Docker/43.png)

## Part 5. Dockle
 + Просканируй образ из предыдущего задания через dockle [image_id|repository].

 Устанавливаем dockle, скачиваем через github: 
 ![Alt text](Docker/44.png)
 Затем сканируем докер-образ через команду `dockle lemonkyl1.0`:
 ![Alt text](Docker/45.png)
+ Исправь образ так, чтобы при проверке через dockle не было ошибок и предупреждений.

Исправили образ:
![Alt text](Docker/46.png)
Ответ скана:
![Alt text](Docker/47.png)


## Part 6. Базовый Docker Compose

+ Напиши файл docker-compose.yml, с помощью которого:
1) Подними докер-контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину).
2) Подними докер-контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера.

+ Замапь 8080 порт второго контейнера на 80 порт локальной машины.
![Alt text](Docker/48.png)
+ Останови все запущенные контейнеры.
+ Собери и запусти проект с помощью команд docker-compose build и docker-compose up.
![Alt text](Docker/49.png)
![Alt text](Docker/50.png)
+ Проверь, что в браузере по localhost:80 отдается написанная тобой страничка, как и ранее.
![Alt text](Docker/51.png)

## СПАСИБО ЗА ВНИМАНИЕ!







