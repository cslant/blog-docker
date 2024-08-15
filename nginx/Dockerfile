FROM nginx:1.27.0-alpine
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"
LABEL authors="cslant"
LABEL description="Nginx image for CSlant development - Using for Blog"

ARG USER_ID=1000
ARG GROUP_ID=1000

## Set Environment
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID

COPY nginx.conf /etc/nginx/

RUN addgroup -g ${USER_ID} www-data; \
    adduser -u ${GROUP_ID} -D -S -G www-data www-data;

WORKDIR /var/dev

EXPOSE 80 443
