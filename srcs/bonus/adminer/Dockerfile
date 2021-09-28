FROM alpine:3.11

ENV ADMINER_VERSION 4.8.1

RUN apk update && \
	apk add --no-cache curl tar gettext mariadb-client \
	php7 php7-fpm php7-mysqli php7-json php7-phar php7-mbstring php7-session

RUN mkdir -p /var/www/adminer/
WORKDIR /var/www/adminer/

RUN addgroup -S adminer && \
	adduser -D -S -s /bin/sh -G adminer adminer && \
	chown -R adminer:adminer /var/www/adminer

# install adminer
RUN set -x && \
	curl -fsSL https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php -o index.php

COPY ./conf/php.ini /etc/php7/
COPY ./conf/www.conf /etc/php7/php-fpm.d/

EXPOSE 8080

CMD ["php-fpm7", "-F"]
