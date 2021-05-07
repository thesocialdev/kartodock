FROM debian:buster

RUN apt-get update && apt-get install -y nodejs \
    git \
    wget \
    python \
    build-essential \
    apt-transport-https \
    ca-certificates \
    fonts-dejavu \
    libboost-filesystem-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libcairo2-dev \
    libfreetype6-dev \
    libgdal-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    libproj-dev \
    libtiff-dev \
    libwebp-dev \
    libxml2-dev \
    libmapbox-variant-dev \
    libboost-program-options-dev \
    libboost-thread-dev \
    apt-transport-https \
    libmapnik3.0 \
    libmapnik-dev \
    mapnik-utils \
    mapnik-doc \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR $HOME/.nvm

# Avoid using cached layers from this point to allow easy changing of nvm version install
ARG CACHEBUST=1 

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
    && . $NVM_DIR/nvm.sh && nvm install 10.15.2

# Install yarn
RUN wget -qO - "https://dl.yarnpkg.com/debian/pubkey.gpg" | apt-key add -
RUN printf "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends yarn

COPY config.tilerator.docker.template.yaml /etc/opt/config.tilerator.docker.template.yaml
COPY config.kartotherian.docker.template.yaml /etc/opt/config.kartotherian.docker.template.yaml
COPY sources.docker.yaml /etc/opt/sources.docker.yaml
COPY generate_config.sh /usr/local/bin/generate_config
RUN chmod +x /usr/local/bin/generate_config

WORKDIR /home/kartotherian
