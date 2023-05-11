# Compile tac_plus
FROM ubuntu:22.04 as build

LABEL Name=tac_plus
LABEL Version=1.3.1

ADD http://www.pro-bono-publico.de/projects/src/tac_plus.tar.bz2 /tac_plus.tar.bz2

RUN apt update && \
    apt install -y apt-utils libpcre2-dev gcc libc6-dev make bzip2 libdigest-md5-perl libnet-ldap-perl libio-socket-ssl-perl && \
    tar -xf /tac_plus.tar.bz2 && \
    cd /PROJECTS && \
    ./configure --with-pcre2 --prefix=/tacacs && \
    make && \
    make install

# Move to a clean, small image
FROM ubuntu:22.04

LABEL maintainer="Lee Keitel <lfkeitel@usi.edu>"

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt update && \
    apt install -y libdigest-md5-perl libnet-ldap-perl  libio-socket-ssl-perl && \
    rm -rf /var/cache/apt/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
