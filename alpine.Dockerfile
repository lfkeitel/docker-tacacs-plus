# Compile tac_plus
FROM alpine:3.18.0 as build

LABEL Name=tac_plus
LABEL Version=1.3.1

ADD http://www.pro-bono-publico.de/projects/src/tac_plus.tar.bz2 /tac_plus.tar.bz2

RUN apk update && \
    apk add build-base bzip2 pcre2 pcre2-dev perl perl-digest-md5 perl-ldap perl-io-socket-ssl bash && \
    tar -xf /tac_plus.tar.bz2 && \
    cd /PROJECTS && \
    ./configure --with-pcre2 --prefix=/tacacs && \
    env SHELL=/bin/bash make && \
    env SHELL=/bin/bash make install

# Move to a clean, small image
FROM alpine:3.18.0

LABEL maintainer="Lee Keitel <lfkeitel@usi.edu>"

COPY --from=build /tacacs /tacacs
COPY tac_plus.sample.cfg /etc/tac_plus/tac_plus.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk update && \
    apk add pcre2 pcre2-dev perl-digest-md5 perl-ldap perl perl-io-socket-ssl && \
    rm -rf /var/cache/apk/*

EXPOSE 49

ENTRYPOINT ["/docker-entrypoint.sh"]
