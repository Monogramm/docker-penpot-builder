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

# Clojure
ENV CLOJURE_VERSION=1.10.0.442
RUN set -ex; \
    curl -L -o clojure-linux-install.sh "https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh"; \
    chmod +x clojure-linux-install.sh; \
    ./clojure-linux-install.sh; \
    rm -rf clojure-linux-install.sh; \
    clojure -h


USER uxbox
WORKDIR /home/uxbox

# Leiningen
COPY files/lein /home/uxbox/.local/bin/lein
RUN set -ex; \
    chmod 755 /home/uxbox/.local/bin/lein; \
    bash -c "/home/uxbox/.local/bin/lein version"

# Node
ENV NODE_VERSION=10.16.0
RUN set -ex; \
    git clone https://github.com/creationix/nvm.git /home/uxbox/.nvm; \
    bash -c "source /home/uxbox/.nvm/nvm.sh && nvm install $NODE_VERSION"; \
    bash -c "source /home/uxbox/.nvm/nvm.sh && nvm alias default $NODE_VERSION"; \
    bash -c "source /home/uxbox/.nvm/nvm.sh && nvm use default"

ENV NVM_DIR=/home/uxbox/.nvm \
    NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules \
    PATH=$HOME/.local/bin:$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

COPY files/bashrc /home/uxbox/.bashrc
COPY files/zshrc /home/uxbox/.zshrc

RUN set -ex; \
    bash -c "java -version"; \
    bash -c "clojure -h"; \
    bash -c "lein version"; \
    bash -c "npm --version"
