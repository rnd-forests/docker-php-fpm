FROM php:7.4-fpm

LABEL MAINTAINER="Nguyen Ngoc Vinh <ngocvinh.nnv@gmail.com>"

ENV TERM xterm

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libmemcached-dev \
    libmemcachedutil2 \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libxml2-dev \
    libbz2-dev \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    libldap2-dev \
    libonig-dev \
    libcurl4 \
    libcurl4-openssl-dev \
    libzip-dev \
    libssh-dev \
    librabbitmq-dev \
    htop \
    curl \
    git \
    vim \
    g++ \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg

RUN docker-php-ext-configure ldap \
    --with-libdir=lib/x86_64-linux-gnu/

RUN docker-php-ext-configure intl

RUN pecl channel-update pecl.php.net \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install memcached redis \
    && docker-php-ext-enable memcached redis \
    && pecl install amqp \
    && docker-php-ext-enable amqp

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    iconv \
    mbstring \
    mysqli \
    curl \
    sockets \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    opcache \
    gd \
    intl \
    soap \
    xml \
    simplexml \
    ldap \
    exif \
    zip \
    pcntl

RUN usermod -u 1000 www-data

WORKDIR /var/www/app

ADD ./conf/php.ini /usr/local/etc/php/conf.d
ADD ./conf/www.conf /usr/local/etc/php-fpm.d/

COPY ./xdebug.ini /tmp/
RUN cat /tmp/xdebug.ini >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY ./docker-entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/docker-entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000
CMD ["php-fpm"]
