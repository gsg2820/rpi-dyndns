# includes static quemu-library for automated builds at TravisCI
FROM yobasystems/alpine:arm32v7
MAINTAINER yobasystems

# update base system
RUN apk add --update ca-certificates perl perl-net-ip wget \
  && rm -rf /var/cache/apk/*

# install init script + ddclient-library
WORKDIR /usr/local/bin
COPY init .
RUN wget 'https://raw.githubusercontent.com/ddclient/ddclient/master/ddclient' \
  && sed -i -e 's/Data::Validate/Net/' ddclient \
  && chmod +x ./*

# configure ddclient-library
RUN mkdir /etc/ddclient /var/cache/ddclient
COPY ddclient.conf /etc/ddclient/

ENTRYPOINT ["/usr/local/bin/init"]
