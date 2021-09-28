include srcs/.env

COMPOSE_FILE	= ./srcs/docker-compose.yml
ENV_FILE		= ./srcs/.env
VOLUMES			= $(shell docker volume ls -q)

GREEN	= \033[32m
YELLOW	= \033[33m
RESET	= \033[0m
LF		= \033[1A\033[K

.PHONY: all up down nginx wordpress mariadb clean re setup

all: up

up: setup $(DATA_DIR)
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up --build

upd: setup $(DATA_DIR)
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

fclean:
	docker stop $(shell docker ps -qa) 2> /dev/null; \
	docker rm $(shell docker ps -qa) 2> /dev/null; \
	docker rmi -f $(shell docker images -qa) 2> /dev/null; \
	docker volume rm $(shell docker volume ls -q) 2> /dev/null; \
	docker network rm $(shell docker network ls -q) 2> /dev/null; \
	echo "$(GREEN)** Done$(RESET)"

re: clean up

ls:
	@echo "$(GREEN)** docker-compose ps$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) ps
	@echo "\n$(GREEN)** docker network ls$(RESET)"
	@docker network ls

setup: install_docker set_host

install_docker:
ifeq ($(shell which docker),)
	sudo ./srcs/tools/install_docker.sh
endif
	sudo chmod 666 /var/run/docker.sock

set_host:
ifeq ($(shell cat /etc/hosts | grep seushin.42.fr),)
	sudo ./srcs/tools/set_host.sh
endif

$(DATA_DIR):
	mkdir -p $(DATA_DIR)/db-data
	mkdir -p $(DATA_DIR)/wp-data
