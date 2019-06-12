FROM ubuntu:bionic

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ARG EXTERNAL_UID=1000

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
        openjdk-8-jdk \
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

WORKDIR /home/uxbox

# Node
ENV NODE_VERSION=10.16.0 \
    NVM_VERSION=0.34.0 \
    NVM_DIR=/usr/local/nvm

RUN set -ex; \
    mkdir -p $NVM_DIR; \
    curl --silent -o- "https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh" | bash

RUN set -ex; \
    . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules \
    PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN node -v; \
    npm -v


# Clojure
ENV CLOJURE_VERSION=1.10.0.442
RUN set -ex; \
    curl --silent -o clojure-linux-install.sh "https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh"; \
    chmod +x clojure-linux-install.sh; \
    ./clojure-linux-install.sh; \
    rm -rf clojure-linux-install.sh; \
    clojure -h


# Leiningen
ENV LEIN_VERSION=2.9.1 \
    LEIN_INSTALL=/usr/local/bin/

WORKDIR /tmp

RUN set -ex; \
    mkdir -p $LEIN_INSTALL \
    && wget -q https://raw.githubusercontent.com/technomancy/leiningen/$LEIN_VERSION/bin/lein-pkg \
    && echo "Comparing lein-pkg checksum ..." \
    && sha1sum lein-pkg \
    && echo "93be2c23ab4ff2fc4fcf531d7510ca4069b8d24a *lein-pkg" | sha1sum -c - \
    && mv lein-pkg $LEIN_INSTALL/lein \
    && chmod 0755 $LEIN_INSTALL/lein \
    && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip \
    && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip.asc \
    && gpg --batch --keyserver pool.sks-keyservers.net --recv-key 2B72BF956E23DE5E830D50F6002AF007D1A7CC18 \
    && echo "Verifying Jar file signature ..." \
    && gpg --verify leiningen-$LEIN_VERSION-standalone.zip.asc \
    && rm leiningen-$LEIN_VERSION-standalone.zip.asc \
    && mkdir -p /usr/share/java \
    && mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar

ENV PATH=$PATH:$LEIN_INSTALL \
    LEIN_ROOT=1

RUN set -ex; \
    java -version; \
    lein version
