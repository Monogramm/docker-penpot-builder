FROM ubuntu:bionic

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

RUN set -ex; \
    apt-get update && \
    apt-get install -yq \
        locales \
        ca-certificates \
        wget \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get update -yq &&  \
    apt-get install -yq \
        bash \
        curl \
        git \
        openjdk-8-jdk \
        rlwrap \
        build-essential \
        imagemagick \
        webp \
    ; \
    mkdir -p /etc/resolvconf/resolv.conf.d; \
    echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/tail; \
    apt-get update -yq; \
    apt-get install -yq \
        libbz2-dev liblzma-dev zlib1g-dev libfftw3-dev \
        libfreetype6-dev libfontconfig1-dev libxt-dev \
        libexif-dev libjpeg-dev libpng-dev libtiff-dev \
        libwmf-dev libpango1.0-dev librsvg2-bin librsvg2-dev \
        libxml2-dev libwebp-dev webp autoconf \
    ; \
    git clone https://github.com/ImageMagick/ImageMagick.git imagemagick && \
    cd imagemagick && \
    git checkout -f 7.0.8-27 && \
    ./configure --prefix=/opt/img && \
    make -j2 && \
    make install && \
    cd .. && \
    rm -rf ./imagemagick

WORKDIR /home/uxbox

ENV NODE_VERSION=10.16.0 \
    CLOJURE_VERSION=1.10.0.442

RUN set -ex; \
    wget "https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh"; \
    chmod +x "linux-install-$CLOJURE_VERSION.sh"; \
    "./linux-install-$CLOJURE_VERSION.sh"; \
    rm -rf "linux-install-$CLOJURE_VERSION.sh"; \
    git clone https://github.com/creationix/nvm.git .nvm; \
    bash -c "source .nvm/nvm.sh && nvm install $NODE_VERSION"; \
    bash -c "source .nvm/nvm.sh && nvm alias default $NODE_VERSION"; \
    bash -c "source .nvm/nvm.sh && nvm use default"; \
    bash -c "/home/uxbox/.local/bin/lein version"

# add node and npm to path so the commands are available
ENV NVM_DIR=/home/uxbox/.nvm \
    NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules \
    PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
