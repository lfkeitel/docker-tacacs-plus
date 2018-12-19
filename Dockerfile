# Compile tac_plus
FROM ubuntu:16.04 as build

MAINTAINER Lee Keitel <lfkeitel@usi.edu>

LABEL Name=tac_plus
LABEL Version=1.0.0

ARG SRC_VERSION
ARG SRC_HASH

ADD http://www.pro-bono-publico.de/projects/src/DEVEL.$SRC_VERSION.tar.bz2 /tac_plus.tar.bz2

RUN echo "${SRC_HASH}  /tac_plus.tar.bz2" | sha256sum -c -

RUN apt update && \
    apt install -y --no-install-recommends gcc libc6-dev make bzip2 libdigest-md5-perl libnet-ldap-perl && \
    tar -xjf /tac_plus.tar.bz2 && \
    cd /PROJECTS && \
    ./configure --prefix=/tacacs && \
    make && \
    make install

# Move to a clean, small image
FROM ubuntu:16.04

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt update && \
    apt install -y --no-install-recommends libdigest-md5-perl libnet-ldap-perl && \
    rm -rf /var/cache/apt/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
