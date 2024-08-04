ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-fpm-alpine
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"
LABEL authors="cslant"
LABEL description="PHP image for CSlant development - Using for Blog"

## Make php ini
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

## Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer

## Config user
ARG USER_ID=1000
ENV USER_ID=${USER_ID}
ARG GROUP_ID=1000
ENV GROUP_ID=${GROUP_ID}

# ensure www-data user exists
RUN set -eu; \
    addgroup -g ${USER_ID} csdev; \
    adduser -D -u ${USER_ID} -G csdev csdev

ADD blog.php.ini "$PHP_INI_DIR/conf.d/blog.ini"
ADD blog.pool.conf /usr/local/etc/php-fpm.d/www.conf

# Default workdir
WORKDIR /var/dev

## Install Ext
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions soap pcntl bcmath gd exif sockets zip xdebug redis intl pdo_pgsql pgsql mysqli

USER csdev

CMD ["php-fpm"]
