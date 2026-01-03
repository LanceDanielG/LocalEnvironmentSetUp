FROM php:8.3-fpm-alpine

RUN apk add --no-cache --update \
    curl \
    bash \
    gcc \
    make \
    autoconf \
    libc-dev \
    linux-headers

# Install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql

# Clean up unnecessary files
RUN apk del gcc make autoconf libc-dev linux-headers

WORKDIR /var/www/html/api

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .

RUN composer install
