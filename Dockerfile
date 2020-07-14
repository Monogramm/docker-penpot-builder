FROM clojure:openjdk-11-tools-deps-1.10.1.547-slim-buster

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"


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
        webp \
        wget \
        zsh \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/resolvconf/resolv.conf.d; \
    echo "nameserver 8.8.8.8" > /etc/resolvconf/resolv.conf.d/tail

# Nodejs and yarn
RUN set -ex; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - ;\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - ;\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
    apt-get update  -yq ; \
    apt-get install -yq nodejs; \
    apt-get install -yq yarn


ARG EXTERNAL_UID=1000

RUN set -ex; \
    useradd -m -g users -s /bin/zsh -u $EXTERNAL_UID uxbox; \
    passwd uxbox -d; \
    echo "uxbox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER uxbox
WORKDIR /home/uxbox


RUN node -v; \
    yarn --version


WORKDIR /tmp

RUN set -ex; \
    java -version
