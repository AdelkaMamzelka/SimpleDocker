FROM nginx
USER root
COPY .nginx//nginx.conf /etc/nginx/nginx.conf
COPY ./web_server.c /home/web_server.c
COPY ./obraz.sh /home/obraz.sh
WORKDIR /home/
RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev && chmod +x obraz.sh
ENTRYPOINT ["sh", "./obraz.sh"]