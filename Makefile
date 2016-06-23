IMAGE_NAME := "azukiapp/elixir-pg-imagick"

# bins
DOCKER := $(shell which adocker || which docker)

all: build test

build:
	${DOCKER} build -t ${IMAGE_NAME}:latest   1.3
	${DOCKER} build -t ${IMAGE_NAME}:1.3      1.3

build-no-cache:
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:latest   1.3
	${DOCKER} build --rm --no-cache -t ${IMAGE_NAME}:1.3      1.3

test:
	# run bats of test to each version
	./test.sh 1.3 1.3.0

.PHONY: all build build-no-cache test
