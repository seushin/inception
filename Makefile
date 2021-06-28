include srcs/.env

COMPOSE_FILE	= ./srcs/docker-compose.yml
VOLUMES			= $(shell docker volume ls -q)

.PHONY: all up down nginx wordpress mariadb clean re

all: up

up: set_host $(DATA_DIR)
	docker-compose -f $(COMPOSE_FILE) up --build -d

down:
	docker-compose -f $(COMPOSE_FILE) down

nginx wordpress mariadb:
	docker-compose -f $(COMPOSE_FILE) exec $@ /bin/sh

clean: down
	rm -rf $(DATA_DIR)
ifneq ($(VOLUMES),)
	docker volume rm $(VOLUMES)
endif

set_host:
ifeq ($(shell cat /etc/hosts | grep seushin.42.fr),)
	echo "127.0.0.1    seushin.42.fr" >> /etc/hosts
endif

$(DATA_DIR):
	mkdir -p $(DATA_DIR)/db-data 
	mkdir -p $(DATA_DIR)/wp-data

re: clean up
