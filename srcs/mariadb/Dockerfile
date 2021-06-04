FROM alpine:3.11

RUN apk update && \
	apk add --no-cache openrc mariadb mariadb-client wget vim

ENV MYSQL_DATA_DIR=/var/lib/mysql

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld ${MYSQL_DATA_DIR}

RUN mysql_install_db --user=mysql --datadir=${MYSQL_DATA_DIR}

COPY ./tools/docker-entrypoint.sh .
COPY ./conf/my.cnf /etc/

EXPOSE 3306

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/usr/bin/mysqld", "--user=mysql", "--skip-name-resolve", "--init-file=/tmp/init", "--debug-gdb"]
