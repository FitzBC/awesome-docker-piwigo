FROM php:7.2-apache
LABEL maintainer="Fitz_BC"

COPY Install.sh /var
COPY piwigo-2.10.1.zip /var

RUN cd /var \
    &&  bash Install.sh

WORKDIR /var/www/html