FROM node:14-alpine3.14

MAINTAINER Trickfilm400 <info@trickfilm400.de>

WORKDIR /app

RUN apk add unzip

ENV URL ""
ENV CACHE "true"
ENV BUILD_TYPESCRIPT "false"

COPY docker-entrypoint.sh /

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]