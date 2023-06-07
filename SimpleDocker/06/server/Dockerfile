FROM nginx

ENV RUN_USER nginx

ENV RUN_GROUP nginx

ENV DATA_DIR /data/web

ENV LOG_DIR /data/log/nginx

RUN mkdir /data/log/nginx -p &&\
    chown nginx.nginx -R /data/log/nginx

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT nginx -g "daemon off;"