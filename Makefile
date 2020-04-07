VERSION?=202004022106
SHA256?=324f9aff25b0e7441243e0f27350f022d9dba864d893c66c2ab6c2771d0c4ebb
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
