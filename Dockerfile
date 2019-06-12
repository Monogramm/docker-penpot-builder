FROM ubuntu:bionic

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

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
        zsh \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/resolvconf/resolv.conf.d; \
    echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/tail

WORKDIR /home/uxbox

# Clojure
ENV CLOJURE_VERSION=1.10.0.442
RUN set -ex; \
    curl -L -o clojure-linux-install.sh "https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh"; \
    chmod +x clojure-linux-install.sh; \
    ./clojure-linux-install.sh; \
    rm -rf clojure-linux-install.sh; \
    clojure -h

# Node
ENV NODE_VERSION=10.16.0
RUN set -ex; \
    git clone https://github.com/creationix/nvm.git .nvm; \
    bash -c "source .nvm/nvm.sh && nvm install $NODE_VERSION"; \
    bash -c "source .nvm/nvm.sh && nvm alias default $NODE_VERSION"; \
    bash -c "source .nvm/nvm.sh && nvm use default"

ENV NVM_DIR=/home/uxbox/.nvm \
    NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules \
    PATH=$HOME/.local/bin:$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN set -ex; \
    bash -c "npm --version"

# Leiningen
COPY lein /home/uxbox/.local/bin/lein
RUN set -ex; \
    chmod 755 /home/uxbox/.local/bin/lein; \
    bash -c "/home/uxbox/.local/bin/lein version"
