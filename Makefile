ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

default: build

build: network
> docker-compose up --build --exit-code-from hugo-builder hugo-builder

test-server:
> docker-compose up hugo-server

deploy:
> ./deploy.sh production

deploy-staging:
> ./deploy.sh staging

network:
> docker network create nginx-proxy || true

.PHONY: default build test-server deploy deploy-staging network
