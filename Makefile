TAC_PLUS_DIR := ./tac_plus

.PHONY: compile build clean

all: compile build

compile:
	@docker build -t tac_plus_tmp -f Dockerfile.compile .
	@docker create --name build-cont tac_plus_tmp
	@rm -rf $(TAC_PLUS_DIR)
	@docker cp build-cont:/tacacs $(TAC_PLUS_DIR)
	@docker rm build-cont
	@docker image rm tac_plus_tmp

build:
	@if [ ! -d "$(TAC_PLUS_DIR)" ]; then echo "tac_plus directory doesn't exist"; exit 1; fi
	@docker build -t tac_plus -f Dockerfile.build .

clean:
	@rm -rf $(TAC_PLUS_DIR)