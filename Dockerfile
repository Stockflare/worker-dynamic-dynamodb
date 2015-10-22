# Start with a base Ubuntu 14:04 image
FROM ubuntu:trusty

MAINTAINER Mark Stratmann <mark@stratmann.me.uk>

# Set up user environment
ENV DEBIAN_FRONTEND noninteractive
RUN adduser --disabled-password --gecos "" nuser && echo "nuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# set HOME so 'npm install' and 'bower install' don't write to /
ENV HOME /home/nuser
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.en
ENV LC_ALL en_US.UTF-8
USER nuser
# RUN sudo locale-gen

# Add all base dependencies
RUN sudo apt-get update
RUN sudo apt-get install -y language-pack-en-base
RUN sudo apt-get install -y vim curl
RUN sudo apt-get install -y build-essential
RUN sudo apt-get install -y git-core
RUN sudo apt-get install -y man
RUN sudo apt-get install -y dnsutils

# Install the latest AWS cli - needed for S3 command line actions in scripts
RUN sudo apt-get install -y python-pip
RUN sudo pip install awscli
RUN sudo pip install dynamic-dynamodb

# Install logging boradcaster
COPY bin/broadcast /usr/bin/broadcast

# Add the application to the container (cwd)
WORKDIR /stockflare
RUN sudo chown -R nuser:nuser /stockflare/

RUN sudo apt-get autoremove -y

# Copy across the rest of the code
ADD . /stockflare
RUN sudo chown -R nuser:nuser .

VOLUME ["/stockflare"]

# Setup the entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
