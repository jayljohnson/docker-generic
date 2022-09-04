CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
CURRENT_USER := ${USER}
DOCKER_IMAGE_PREFIX := ${shell pwd | awk -F/ '{print $$NF}'}

all: version

version:
	echo ${DOCKER_IMAGE_PREFIX}
	docker exec -ti ${DOCKER_IMAGE_PREFIX}_application_1 sh -c "echo Python Version: && python3 --version"

up:
	docker-compose up -d
	docker container ps

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up -d
	docker ps

build:
	docker-compose build

psql:
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_db_1 sh -c "psql -h localhost -p 5432 -U postgres -w"

cli:
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 /bin/bash

shell:
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 sh -c "python"

permissions:
	# Run with -i flag to ignore errors, `make permissions -i`
	sudo groupadd docker
	sudo usermod -aG docker ${USER}
	sudo newgrp docker

deploy-staging:
	git checkout deploy/staging
	git fetch origin deploy/staging
	git reset --hard origin/deploy/staging
	git merge --no-edit ${CURRENT_BRANCH}
	git push -u origin deploy/staging
	git checkout ${CURRENT_BRANCH}

deploy-prod:
	git checkout main
	git fetch origin main
	git reset --hard origin/main
	git merge --no-edit ${CURRENT_BRANCH}
	git push -u origin main
	git checkout ${CURRENT_BRANCH}