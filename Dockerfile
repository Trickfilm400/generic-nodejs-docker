FROM node:16-alpine3.16

MAINTAINER Trickfilm400 <info@trickfilm400.de>

WORKDIR /app

RUN apk add unzip

ENV URL ""
ENV CACHE "true"
ENV BUILD_TYPESCRIPT "false"

COPY docker-entrypoint.sh /

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]