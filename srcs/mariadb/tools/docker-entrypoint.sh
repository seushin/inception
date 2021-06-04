#!/bin/sh

# init 파일 생성
touch /tmp/init
if [ ! -n "$MYSQL_ROOT_PASSWORD" ]; then
	MYSQL_ROOT_PASSWORD=mysqlroot
	export MYSQL_ROOT_PASSWORD
fi

echo "** creating init file: /tmp/init"
echo "GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> /tmp/init
echo "SET PASSWORD FOR 'root'@'%' = PASSWORD('${MYSQL_ROOT_PASSWORD}');" >> /tmp/init
echo "DROP DATABASE IF EXISTS test;" >> /tmp/init

if [ -n "$MYSQL_DATABASE" ]; then
	echo "** creating database: ${MYSQL_DATABASE}"
	echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> /tmp/init
	if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
		echo "GRANT ALL ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /tmp/init
	fi
fi
echo "FLUSH PRIVILEGES;" >> /tmp/init

if [[ "$1" == -* ]]; then
	eval /usr/bin/mysqld --user=mysql --skip-name-resolve --init-file=/tmp/init --debug-gdb "$@"
else
	exec "$@"
fi
