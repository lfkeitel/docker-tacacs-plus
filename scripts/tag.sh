#!/bin/sh
VERSION="$1"

if [ -z "$VERSION" ]; then
    echo 'I need a version to tag'
    exit 1
fi

docker tag tac_plus:alpine lfkeitel/tacacs_plus:alpine
docker tag tac_plus:alpine lfkeitel/tacacs_plus:alpine-$VERSION

docker tag tac_plus:ubuntu lfkeitel/tacacs_plus:latest
docker tag tac_plus:ubuntu lfkeitel/tacacs_plus:ubuntu
docker tag tac_plus:ubuntu lfkeitel/tacacs_plus:ubuntu-$VERSION

docker push lfkeitel/tacacs_plus:alpine
docker push lfkeitel/tacacs_plus:alpine-$VERSION
docker push lfkeitel/tacacs_plus:latest
docker push lfkeitel/tacacs_plus:ubuntu
docker push lfkeitel/tacacs_plus:ubuntu-$VERSION
