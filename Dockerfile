FROM nginx:alpine

LABEL MAINTAINER="zhangsean <zxf2342@qq.com>"

ENV LISTEN_PORT=80 \
    PROTO=tcp \
    REMOTE_SERVER=example.com \
    REMOTE_PORT=80

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]