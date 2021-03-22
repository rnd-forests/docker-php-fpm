# PHP FPM (FastCGI Process Manager)

Project root directory should be mapped to `/var/www/app` inside the container.

### Extensions
Installed PHP extensions:
- `gd`
- `ldap`
- `mongodb`
- `xdebug`
- `redis`
- `memcached`
- `bcmath`
- `bz2`
- `calendar`
- `iconv`
- `mbstring`
- `mysqli`
- `pdo_mysql`
- `pdo_pgsql`
- `pgsql`
- `opcache`
- `intl`
- `soap`
- `exif`
- `zip`
- `pcntl`
- `curl`
- `xml`
- `simplexml`

### Xdebug
The default configuration file for Xdebug is similar to:

```ini
zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_port=9000
xdebug.remote_autostart=1
xdebug.remote_connect_back=0
xdebug.idekey=docker
xdebug.remote_host=
```

Xdebug can be configured through some environment variables:
- `XDEBUG_HOST`
- `XDEBUG_PORT` (default to `9000`)
- `XDEBUG_IDE_KEY` (default to `docker`)

For example, if you're using Docker Compose, we can define the service as follow:

```yml
php-fpm:
    image: vinhnguyen1512/laravel-php-fpm
    restart: always
    volumes:
      - ${PROJECT_ROOT}:/var/www/app
    expose:
      - "9000"
    environment:
      XDEBUG_HOST: ${XDEBUG_HOST}
      XDEBUG_PORT: ${XDEBUG_PORT:-9000}
      XDEBUG_IDE_KEY: ${XDEBUG_IDE_KEY:-docker}
```
