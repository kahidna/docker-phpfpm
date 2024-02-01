FROM debian:12
MAINTAINER alfin <kahid.na@gmail.com>

ENV OS_LOCALE="en_US.UTF-8" \
    DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE}

ENV PHP_RUN_DIR=/run/php \
    PHP_LOG_DIR=/var/log/php \
    PHP_CONF_DIR=/etc/php/8.1 \
    PHP_DATA_DIR=/var/lib/php

RUN BUILD_DEPS='software-properties-common wget python3-launchpadlib' \
    dpkg-reconfigure locales  && apt-get install --no-install-recommends -y $BUILD_DEPS \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y curl php8.1-fpm php8.1-cli php8.1-readline php8.1-mbstring php8.1-zip php8.1-intl php8.1-xml php8.1-curl php8.1-gd php8.1-pgsql php8.1-mysql php-pear php8.1-imagick \
    && curl -sS https://getcomposer.org/installer | php -- --version=2.6.6 --install-dir=/usr/local/bin --filename=composer \
    && mkdir -p ${PHP_LOG_DIR} ${PHP_RUN_DIR} \
    && apt-get purge -y --auto-remove $BUILD_DEPS \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./configs/php-fpm.conf ${PHP_CONF_DIR}/fpm/php-fpm.conf
COPY ./configs/www.conf ${PHP_CONF_DIR}/fpm/pool.d/www.conf
COPY ./configs/php.ini ${PHP_CONF_DIR}/fpm/conf.d/custom.ini

RUN sed -i "s~PHP_RUN_DIR~${PHP_RUN_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
    && sed -i "s~PHP_LOG_DIR~${PHP_LOG_DIR}~g" ${PHP_CONF_DIR}/fpm/php-fpm.conf \
    && chown www-data:www-data ${PHP_DATA_DIR} -Rf

WORKDIR /var/www

EXPOSE 9000

# PHP_DATA_DIR store sessions
VOLUME ["${PHP_RUN_DIR}", "${PHP_DATA_DIR}"]
CMD ["/usr/sbin/php-fpm8.1"]
