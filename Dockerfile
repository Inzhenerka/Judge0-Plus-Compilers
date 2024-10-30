# Check for latest version here: https://hub.docker.com/_/buildpack-deps?tab=tags&page=1&name=buster&ordering=last_updated
FROM buildpack-deps:oracular

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install ruby-full
RUN apt-get -y install python3.13-full
RUN apt-get -y install octave
RUN apt-get -y install openjdk-23-jdk
RUN apt-get -y install nodejs npm
RUN apt -y install rustc
RUN apt-get -y install golang-go
RUN npm install -g typescript
RUN apt-get -y install sqlite3

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends git libcap-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/judge0/isolate.git /tmp/isolate && \
    cd /tmp/isolate && \
    git checkout ad39cc4d0fbb577fb545910095c9da5ef8fc9a1a && \
    make -j$(nproc) install && \
    rm -rf /tmp/*
ENV BOX_ROOT /var/local/lib/isolate

LABEL maintainer="Inzhenerka.Tech <info@inzhenerka.tech>"
LABEL version="1.4.0-plus"
