#!/bin/sh

# TODO: config 파일에 환경변수 치환해놓기
envsubst '$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD' < /var/www/wordpress/wp-config.php > /tmp/wp-config.php
mv /tmp/wp-config.php /var/www/wordpress/wp-config.php

exec "$@"
