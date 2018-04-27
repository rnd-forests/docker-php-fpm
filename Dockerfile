FROM php:7.2-fpm

MAINTAINER Nguyen Ngoc Vinh <ngocvinh.nnv@gmail.com>

ENV TERM xterm

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libmemcached-dev \
    curl \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    zlib1g-dev libicu-dev g++ \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure intl

RUN pecl channel-update pecl.php.net \
    && pecl install mongodb \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install \
    mcrypt \
    bcmath \
    pdo_mysql \
    pdo_pgsql \
    intl \
    zip

RUN usermod -u 1000 www-data

WORKDIR /var/www/app

ADD ./conf/php.ini /usr/local/etc/php/conf.d
ADD ./conf/www.conf /usr/local/etc/php-fpm.d/

CMD ["php-fpm"]

EXPOSE 9000
