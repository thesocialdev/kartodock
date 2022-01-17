FROM debian:bullseye

RUN apt-get update && apt-get install -y nodejs npm \
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
    && rm -rf /var/lib/apt/lists/*

# Explicitly set $HOME variable to avoid an issue with nvm setup
ENV HOME /root
ENV NVM_DIR $HOME/.nvm
RUN chown -R 1000:1000 $HOME

# Avoid using cached layers from this point to allow easy changing of nvm version install
ARG CACHEBUST=1

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh && nvm install 10.15.2

COPY config.kartotherian.docker.template.yaml /etc/opt/config.kartotherian.docker.template.yaml
COPY generate_config.sh /usr/local/bin/generate_config
RUN chmod +x /usr/local/bin/generate_config

WORKDIR /home/kartotherian
