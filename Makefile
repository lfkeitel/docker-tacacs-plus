.PHONY: alpine ubuntu

all: alpine ubuntu

alpine:
	docker build -t tac_plus:alpine -f Dockerfile.alpine .

ubuntu:
	docker build -t tac_plus:ubuntu -f Dockerfile .
