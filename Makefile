include srcs/.env

up:
	cd srcs && docker-compose up --build -d

down:
	cd srcs && docker-compose down

clean: down
	docker volume rm ${COMPOSE_PROJECT_NAME}_db-data ${COMPOSE_PROJECT_NAME}_wp-data

re: down clean up
