VERSION=201712190728
SHA256=c7a8dbc5e6561a2fbc608142520a88e05fda22e9a664f3184ffe2f8b4821cf2c

.PHONY: alpine ubuntu

all: alpine ubuntu

alpine:
	docker build -t tac_plus:alpine \
		--build-arg SRC_VERSION=$(VERSION) --build-arg SRC_HASH=$(SHA256) \
		-f alpine.Dockerfile .

ubuntu:
	docker build -t tac_plus:ubuntu \
		--build-arg SRC_VERSION=$(VERSION) --build-arg SRC_HASH=$(SHA256) \
		-f Dockerfile .
