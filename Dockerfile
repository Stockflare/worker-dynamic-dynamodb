FROM ubuntu:trusty

MAINTAINER Stockflare <info@stockflare.com>

ENV DEBIAN_FRONTEND noninteractive

ENV AWS_REGION us-east-1

ENV CONFD_VERSION 0.10.0

RUN apt-get update && apt-get install -y language-pack-en-base vim curl build-essential git-core \
      man dnsutils python-pip && apt-get autoremove -y

RUN sudo pip install awscli dynamic-dynamodb

ADD etc/confd /etc/confd

ADD confd/confd-0.10.0-linux-amd64 /bin/confd

COPY bin/broadcast /usr/bin/broadcast

WORKDIR /stockflare

ADD boot boot

CMD ["./boot"]
