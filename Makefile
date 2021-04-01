VERSION?=202103211023
SHA256?=65bafc17f454950bd131d3799e2cc92459a1cbcae0166edec78a8853d10da107
DOCKER_HUB_NAME?='lfkeitel/tacacs_plus'

.PHONY: alpine ubuntu tag

all: alpine ubuntu

alpine:
	docker build -t tac_plus:alpine \
		--build-arg SRC_VERSION=$(VERSION) \
		--build-arg SRC_HASH=$(SHA256) \
		-f alpine.Dockerfile .

ubuntu:
	docker build -t tac_plus:ubuntu \
		--build-arg SRC_VERSION=$(VERSION) \
		--build-arg SRC_HASH=$(SHA256) \
		-f Dockerfile .

tag:
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):latest
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):ubuntu
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):ubuntu-$(VERSION)

	docker tag tac_plus:alpine $(DOCKER_HUB_NAME):alpine
	docker tag tac_plus:alpine $(DOCKER_HUB_NAME):alpine-$(VERSION)
