#!/bin/sh

# 인증서가 없다면 생성
if [ ! -e /etc/ssl/certs/seushin.42.fr.crt ] ||
		[ ! -e /etc/ssl/private/seushin.42.fr.key ]; then
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
		-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gun/CN=seushin.42.fr" \
		-keyout /etc/ssl/private/seushin.42.fr.key \
		-out /etc/ssl/certs/seushin.42.fr.crt
	chmod 600 /etc/ssl/certs/seushin.42.fr.crt /etc/ssl/private/seushin.42.fr.key
fi

exec "$@"
