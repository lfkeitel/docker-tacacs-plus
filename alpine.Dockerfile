# Compile tac_plus
FROM alpine:3.9 as build

LABEL Name=tac_plus
LABEL Version=1.1.0

ARG SRC_VERSION
ARG SRC_HASH

ADD https://github.com/lfkeitel/event-driven-servers/archive/$SRC_VERSION.tar.gz /tac_plus.tar.gz

RUN echo "${SRC_HASH}  /tac_plus.tar.gz" | sha256sum -c -

RUN apk update && \
    apk add build-base bzip2 perl perl-digest-md5 perl-ldap bash && \
    tar -xzf /tac_plus.tar.gz && \
    cd /event-driven-servers-$SRC_VERSION && \
    ./configure --prefix=/tacacs && \
    env SHELL=/bin/bash make && \
    env SHELL=/bin/bash make install

# Move to a clean, small image
FROM alpine:3.9

LABEL maintainer="Lee Keitel <lfkeitel@usi.edu>"

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk update && \
    apk add perl-digest-md5 perl-ldap && \
    rm -rf /var/cache/apk/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
