VERSION?=201908261951
SHA256?=d5fbdf68b7a45d6cb58fb9db1192c300fb263a7c8f058b0b39cc596a6e906603
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
