ARG PHP_VERSION=8.3
ARG PHP_VERSION_SHORT=83

FROM nginx:1.26.0-alpine
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"
LABEL authors="cslant"
LABEL description="Nginx image for CSlant development - Using for Blog"

COPY nginx.conf /etc/nginx/

RUN addgroup -g ${PHP_VERSION_SHORT} -S www-data ; \
    adduser -u ${PHP_VERSION_SHORT} -D -S -G www-data www-data;

WORKDIR /var/dev

EXPOSE 80 443
