FROM clojure:openjdk-11-tools-deps-1.10.1.547-slim-buster

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ARG EXTERNAL_UID=1000

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Packages
RUN set -ex; \
    apt-get update -yq &&  \
    apt-get install -yq \
        bash \
        build-essential \
        ca-certificates \
        curl \
        git \
        imagemagick \
        locales \
        rlwrap \
        rsync \
        sudo \
        webp \
        wget \
        zsh \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/resolvconf/resolv.conf.d; \
    echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/tail

# Nodejs and yarn
RUN set -ex; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN set -ex; \
    apt-get install -yq \
        nodejs \
        yarn


USER uxbox
WORKDIR /home/uxbox


RUN node -v; \
    yarn --version


WORKDIR /tmp

RUN set -ex; \
    java -version
