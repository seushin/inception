include srcs/.env

D_DATA = srcs/data
VOLUMES = $(shell docker volume ls -q)

up: $(D_DATA)
	cd srcs && docker-compose up -d --build

down:
	cd srcs && docker-compose down

ifneq ($(VOLUMES),)
clean: down
	docker volume rm $(VOLUMES)
	rm -rf $(D_DATA)
else
clean: down
	rm -rf $(D_DATA)
endif

$(D_DATA):
	mkdir -p $(D_DATA)/db-data $(D_DATA)/wp-data

re: down clean up
