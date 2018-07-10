#!/bin/bash
set -e

xdebugini=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

if [[ -n "$XDEBUG_HOST" ]]; then
    sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\=$XDEBUG_HOST/g" "$xdebugini"
fi

if [[ -n "$XDEBUG_PORT" ]]; then
    sed -i "s/xdebug\.remote_port\=.*/xdebug\.remote_port\=$XDEBUG_PORT/g" "$xdebugini"
fi

if [[ -n "$XDEBUG_IDE_KEY" ]]; then
    sed -i "s/xdebug\.idekey\=.*/xdebug\.idekey\=$XDEBUG_IDE_KEY/g" "$xdebugini"
fi

exec "$@"
