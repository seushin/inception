up:
	cd srcs && docker-compose up --build -d

down:
	cd srcs && docker-compose down

clean: down
	docker volume rm srcs_db-data srcs_wp-data

re: down clear up
