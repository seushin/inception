#!/bin/sh

if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "** creating wp-config file"
	# envsubst '$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD' < /tmp/wp-config.php > /var/www/wordpress/wp-config.php
	wp config create \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb:3306

	echo "** wp core install.."
	wp core install \
		--url=${DOMAIN_NAME} \
		--title=${COMPOSE_PROJECT_NAME} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--skip-email

	echo "** wp user create ${WP_USER}.."
	wp user create ${WP_USER} ${WP_USER_EMAIL} \
		--user_pass=${WP_USER_PASSWORD} \
		--role=author
	# echo "** rm /tmp/wp-config.php"
	# rm -f /tmp/wp-config.php
fi

echo "** run $@"
exec "$@"
