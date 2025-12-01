DOCKER_SERVICE ?= app

.PHONY: build
build:
	docker compose build $(DOCKER_SERVICE)

.PHONY: start
up: build docker_node_modules
	docker compose up -d --remove-orphans $(DOCKER_SERVICE)
	docker compose logs --tail=50 $(DOCKER_SERVICE)

.PHONY: stop
down:
	docker compose down --remove-orphans $(DOCKER_SERVICE)

# docker node_module is mounted as a volume, so we need to install dependencies in the container
.PHONY: docker_node_modules
docker_node_modules: package.json pnpm-lock.yaml
	docker compose run --rm $(DOCKER_SERVICE) pnpm install -f

logs:
	docker compose logs -f --tail=50 $(DOCKER_SERVICE)

sh:
	docker compose exec $(DOCKER_SERVICE) zsh