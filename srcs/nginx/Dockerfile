FROM alpine:3.11

RUN apk update && \
	apk add \
	nginx \
	php7 \
	php7-fpm \
	php7-mysqli

EXPOSE 443

CMD ["/bin/sh"]
