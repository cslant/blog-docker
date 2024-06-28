FROM nginx:1.26.0-alpine3.19
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"

COPY nginx.conf /etc/nginx/

RUN addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data;

WORKDIR /var/dev

EXPOSE 80 443
