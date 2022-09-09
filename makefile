CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
CURRENT_USER := ${USER}
DOCKER_IMAGE_PREFIX := ${shell pwd | awk -F/ '{print $$NF}'}

all: version

version: up
	@echo 'Base directory: ${DOCKER_IMAGE_PREFIX}'
	docker exec -ti ${DOCKER_IMAGE_PREFIX}_application_1 sh -c "echo Python Version: && python3 --version"

up:
	docker-compose up -d
	docker container ps

down:
	docker-compose down

restart:
	docker-compose restart
	docker container ps

build: down
	docker-compose build

test: up
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 coverage run --branch -m pytest
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 coverage report

psql: up
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_db_1 sh -c "psql -h localhost -p 5432 -U postgres -w"

cli: up
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 /bin/bash

python: up
	docker exec -ti  ${DOCKER_IMAGE_PREFIX}_application_1 sh -c "python"

permissions:
	sudo chown -R ${USER}:${USER} .git
	sudo chown -R ${USER}:${USER} data
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
