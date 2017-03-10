TAC_PLUS_DIR := ./tac_plus
TAC_PLUS_DOCKER_TAG ?= tac_plus

.PHONY: compile build clean

all: compile build

compile:
	@docker build -t $(TAC_PLUS_DOCKER_TAG)_tmp -f Dockerfile.compile .
	@docker create --name build-cont $(TAC_PLUS_DOCKER_TAG)_tmp
	@rm -rf $(TAC_PLUS_DIR)
	@docker cp build-cont:/tacacs $(TAC_PLUS_DIR)
	@docker rm build-cont
	@docker image rm $(TAC_PLUS_DOCKER_TAG)_tmp

build:
	@if [ ! -d "$(TAC_PLUS_DIR)" ]; then echo "$(TAC_PLUS_DIR) directory doesn't exist"; exit 1; fi
	@docker build -t $(TAC_PLUS_DOCKER_TAG) -f Dockerfile.build .

clean:
	@rm -rf $(TAC_PLUS_DIR)