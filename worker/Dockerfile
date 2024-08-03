ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-cli-alpine

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ARG USER_ID=1000
ENV USER_ID ${USER_ID}
ARG GROUP_ID=1000
ENV GROUP_ID ${GROUP_ID}

RUN set -eu; \
    addgroup -g ${USER_ID} csdev; \
    adduser -D -u ${USER_ID} -G csdev csdev

ADD blog.php.ini "$PHP_INI_DIR/conf.d/blog.ini"

WORKDIR /var/dev

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions soap pcntl bcmath gd exif sockets zip xdebug redis intl pdo_pgsql pgsql mysqli

## Install supervisord
RUN apk add --no-cache supervisor

ADD supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
