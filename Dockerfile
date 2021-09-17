# Compile tac_plus
FROM ubuntu:20.04 as build

LABEL Name=tac_plus
LABEL Version=1.3.0

ARG SRC_VERSION
ARG SRC_HASH

ADD https://github.com/lfkeitel/event-driven-servers/archive/refs/tags/$SRC_VERSION.tar.gz /tac_plus.tar.gz

RUN echo "${SRC_HASH}  /tac_plus.tar.gz" | sha256sum -c -

RUN apt update && \
    apt install -y gcc libc6-dev make bzip2 libdigest-md5-perl libnet-ldap-perl libio-socket-ssl-perl && \
    tar -xzf /tac_plus.tar.gz && \
    cd /event-driven-servers-$SRC_VERSION && \
    ./configure --prefix=/tacacs && \
    make && \
    make install

# Move to a clean, small image
FROM ubuntu:20.04

LABEL maintainer="Lee Keitel <lfkeitel@usi.edu>"

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt update && \
    apt install -y libdigest-md5-perl libnet-ldap-perl  libio-socket-ssl-perl && \
    rm -rf /var/cache/apt/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
