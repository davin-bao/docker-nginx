FROM nginx:1.13.0-alpine
MAINTAINER Davin Bao <davin.bao@gmail.com>

RUN set -x \
    && addgroup -g 1982 -S www \
    && adduser -u 1982 -D -S -G www www

RUN set -xe \
    && mkdir -p /home/www/conf \
    && mkdir -p /home/www/logs

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME ["/home/www"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
