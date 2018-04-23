VERSION=201712190728
SHA256=c7a8dbc5e6561a2fbc608142520a88e05fda22e9a664f3184ffe2f8b4821cf2c
DOCKER_HUB_NAME='lfkeitel/tacacs_plus'

.PHONY: alpine ubuntu tag

all: alpine ubuntu

alpine:
	docker build -t tac_plus:alpine \
		--build-arg SRC_VERSION=$(VERSION) --build-arg SRC_HASH=$(SHA256) \
		-f alpine.Dockerfile .

ubuntu:
	docker build -t tac_plus:ubuntu \
		--build-arg SRC_VERSION=$(VERSION) --build-arg SRC_HASH=$(SHA256) \
		-f Dockerfile .

tag:
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):latest
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):ubuntu
	docker tag tac_plus:ubuntu $(DOCKER_HUB_NAME):ubuntu-$(VERSION)

	docker tag tac_plus:alpine $(DOCKER_HUB_NAME):alpine
	docker tag tac_plus:alpine $(DOCKER_HUB_NAME):alpine-$(VERSION)
