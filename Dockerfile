FROM nginx:1.13.0-alpine
MAINTAINER Davin Bao <davin.bao@gmail.com>

ENV WORKDIR /home/www
ENV CONFDIR /etc/nginx
ENV LOGDIR /var/log/nginx
ENV TIMEZONE UTC

RUN set -x \
    && addgroup -g 1982 -S www \
    && adduser -u 1982 -D -S -G www www

RUN set -xe \
    && mkdir -p $CONFDIR \
    && mkdir -p $LOGDIR

#设置时区
ENV TIMEZONE Etc/UTC
RUN set -xe \
    && apk add --update tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    apk del tzdata

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME [$WORKDIR]

EXPOSE 80

STOPSIGNAL SIGQUIT

