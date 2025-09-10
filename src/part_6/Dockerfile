FROM nginx
USER root
COPY .nginx//nginx.conf /etc/nginx/nginx.conf
COPY ./web_server.c /home/web_server.c
COPY ./obraz.sh /home/obraz.sh
RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    chown -R nginx:nginx /etc/nginx/nginx.conf; \
    chown -R nginx:nginx /var/cache/nginx; \
    chown -R nginx:nginx /home; \
    touch /var/run/nginx.pid; \
    chown -R nginx:nginx /var/run/nginx.pid; \
    chmod g-s /sbin/unix_chkpwd; \
    chmod u-s /usr/bin/chfn; \
    chmod g-s /usr/bin/wall; \
    chmod u-s /usr/bin/passwd; \
    chmod g-s /usr/bin/expiry; \
    chmod u-s /usr/bin/newgrp; \
    chmod u-s /bin/mount; \
    chmod u-s /usr/bin/gpasswd; \
    chmod u-s /bin/su; \
    chmod u-s /bin/umount; \
    chmod u-s /usr/bin/chsh; \
    chmod g-s /usr/bin/chage;
WORKDIR /home/
ENTRYPOINT ["sh", "./obraz.sh"]