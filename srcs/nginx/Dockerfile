FROM alpine:3.11

RUN apk update && \
	apk add --no-cache nginx openssl curl

RUN mkdir -p /run/nginx/ && \
	mkdir -p /var/www/wordpress/

COPY ./conf/default.conf /etc/nginx/conf.d/
COPY ./tools/docker-entrypoint.sh .

EXPOSE 443

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
