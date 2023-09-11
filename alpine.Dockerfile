# Compile tac_plus
FROM alpine:3.14 as build

LABEL Name=tac_plus
LABEL Version=1.4.0

ARG SRC_VERSION
ARG SRC_HASH

ADD https://github.com/tanis2000/event-driven-servers/archive/refs/tags/$SRC_VERSION.tar.gz /tac_plus.tar.gz

RUN echo "${SRC_HASH}  /tac_plus.tar.gz" | sha256sum -c -

RUN apk update && \
    apk add build-base bzip2 perl perl-digest-md5 perl-ldap perl-io-socket-ssl bash && \
    tar -xzf /tac_plus.tar.gz && \
    cd /event-driven-servers-$SRC_VERSION && \
    ./configure --prefix=/tacacs && \
    env SHELL=/bin/bash make && \
    env SHELL=/bin/bash make install

# Move to a clean, small image
FROM alpine:3.14

LABEL maintainer="Valerio Santinelli <santinelli@gmail.com>"

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk update && \
    apk add perl-digest-md5 perl-ldap perl perl-io-socket-ssl && \
    rm -rf /var/cache/apk/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
