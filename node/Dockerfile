FROM node:22.0.0-alpine
LABEL maintainer="Tan Nguyen <tannp27@gmail.com>"
LABEL authors="cslant"
LABEL description="Node.js image for CSlant development - Using for Blog"

ARG USER_ID=1000
ARG GROUP_ID=1000

## Set Environment
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID

RUN apk add --no-cache git

RUN deluser node

## Add user
RUN addgroup -g ${USER_ID} csdev; \
    adduser -D -u ${USER_ID} -G csdev csdev

USER csdev

RUN echo Y | yarn -v

WORKDIR /var/dev

CMD ["ash", "-l"]
