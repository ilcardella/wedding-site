ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

default: build

build:
> docker-compose up --build --exit-code-from hugo-builder hugo-builder

test-server:
> docker-compose up hugo-server

.PHONY: default build test-server
