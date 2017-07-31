FROM nginx:1.13.0-alpine
MAINTAINER Davin Bao <davin.bao@gmail.com>

ENV WORKDIR /home/www
ENV TIMEZONE UTC

RUN set -x \
    && addgroup -g 1982 -S www \
    && adduser -u 1982 -D -S -G www www

#设置时区
ENV TIMEZONE Etc/UTC
RUN set -xe \
    && apk add --update tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    apk del tzdata

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

VOLUME [$WORKDIR]

EXPOSE 80

STOPSIGNAL SIGQUIT

