include srcs/.env

COMPOSE_FILE	= ./srcs/docker-compose.yml
ENV_FILE		= ./srcs/.env
VOLUMES			= $(shell docker volume ls -q)

.PHONY: all up down nginx wordpress mariadb clean re

all: up

up: set_host $(DATA_DIR)
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up --build -d

down:
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down

nginx wordpress mariadb:
	docker-compose -f $(COMPOSE_FILE) exec $@ /bin/sh

clean: down
	sudo rm -rf $(DATA_DIR)
ifneq ($(VOLUMES),)
	docker volume rm $(VOLUMES)
endif

set_host:
ifeq ($(shell cat /etc/hosts | grep seushin.42.fr),)
	sudo ./srcs/tools/set_host.sh
endif

$(DATA_DIR):
	mkdir -p $(DATA_DIR)/db-data
	mkdir -p $(DATA_DIR)/wp-data

re: clean up
