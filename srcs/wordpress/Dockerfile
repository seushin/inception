FROM alpine:3.11

RUN apk update && \
	apk add --no-cache wget tar gettext mariadb-client \
	php7 php7-fpm php7-mysqli php7-json php7-phar php7-mbstring

WORKDIR /var/www/

RUN addgroup -g 82 -S www-data && \
	adduser -u 82 -D -S -s /bin/sh -G www-data www-data

# install wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvf latest.tar.gz && \
	rm -rf latest.tar.gz

# install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar &&\
	mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/
RUN wp core download --locale=ko_KR

COPY ./conf/php.ini /etc/php7/
COPY ./conf/www.conf /etc/php7/php-fpm.d/
COPY ./tools/docker-entrypoint.sh /usr/local/bin/

EXPOSE 9000

WORKDIR /var/www/wordpress

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm7", "-F"]
