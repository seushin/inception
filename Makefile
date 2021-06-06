include srcs/.env

VOLUMES = $(shell docker volume ls -q)

up: $(DATA_DIR)
	cd srcs && docker-compose up -d --build

down:
	cd srcs && docker-compose down

clean: down
ifeq ($(VOLUMES),)
	rm -rf $(DATA_DIR)
else
	docker volume rm $(VOLUMES)
	rm -rf $(DATA_DIR)
endif

$(DATA_DIR):
	mkdir -p $(DATA_DIR)/db-data $(DATA_DIR)/wp-data

re: down clean up
