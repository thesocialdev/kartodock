FROM debian:stretch

RUN apt-get update && apt-get install -y nodejs \
	nodejs-legacy \
	git \
	wget \
	python \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev libboost-thread-dev \
    libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libcairo2 libcairo2-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    build-essential \
    libgdal-dev \
    libharfbuzz-bin \
    libharfbuzz-dev \
    libmapnik-dev \
 	&& rm -rf /var/lib/apt/lists/*

# This library is enough to run kartotherian
RUN wget https://apt.wikimedia.org/mapnik/libmapnik3.0_3.0.20%2Bds-1_amd64.deb && \
    dpkg -i libmapnik3.0_3.0.20+ds-1_amd64.deb && \
    rm libmapnik3.0_3.0.20+ds-1_amd64.deb

RUN wget https://apt.wikimedia.org/mapnik/libmapnik-dev_3.0.20%2Bds-1_amd64.deb && \
    dpkg -i libmapnik-dev_3.0.20+ds-1_amd64.deb && \
    rm libmapnik-dev_3.0.20+ds-1_amd64.deb

RUN wget https://apt.wikimedia.org/mapnik/mapnik-doc_3.0.20%2Bds-1_all.deb && \
    dpkg -i mapnik-doc_3.0.20+ds-1_all.deb && \
    rm mapnik-doc_3.0.20+ds-1_all.deb

RUN wget https://apt.wikimedia.org/mapnik/mapnik-utils_3.0.20%2Bds-1_amd64.deb && \
    dpkg -i mapnik-utils_3.0.20+ds-1_amd64.deb && \
    rm mapnik-utils_3.0.20+ds-1_amd64.deb

ENV NVM_DIR $HOME/.nvm

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
	&& . $NVM_DIR/nvm.sh && nvm install 6.11.1

COPY config.docker.yaml /etc/opt/config.docker.yaml
COPY sources.docker.yaml /etc/opt/sources.docker.yaml
COPY start.sh /usr/local/bin/start.sh

WORKDIR /home/kartotherian

CMD /bin/bash /usr/local/bin/start.sh
