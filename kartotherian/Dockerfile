FROM debian:stretch

RUN apt-get update && apt-get install -y nodejs \
	nodejs-legacy \
	git \
	wget \
	python \
    build-essential \
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

# Backported mapnik 3.0.20 from Wikimedia Stretch
# RUN printf "deb https://apt.wikimedia.org/wikimedia stretch-wikimedia main" >> /etc/apt/sources.list
# RUN wget -qO - "https://wikitech.wikimedia.org/w/index.php?title=APT_repository/Stretch-Key&action=raw" | apt-key add -
# RUN apt-get update && apt-get install -y -t stretch-wikimedia libmapnik3.0 libmapnik-dev mapnik-utils mapnik-doc

# Install mapnik from source
RUN git clone https://github.com/mapnik/mapnik.git /tmp/mapnik
RUN cd /tmp/mapnik && git submodule update --init
RUN cd /tmp/mapnik && ./configure
RUN cd /tmp/mapnik && make
# RUN cd /tmp/mapnik && make test
RUN cd /tmp/mapnik && make install

ENV NVM_DIR $HOME/.nvm

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
	&& . $NVM_DIR/nvm.sh && nvm install 10.14.2

COPY config.docker.yaml /etc/opt/config.docker.yaml
COPY sources.docker.yaml /etc/opt/sources.docker.yaml
COPY start.sh /usr/local/bin/start.sh

WORKDIR /home/kartotherian

# CMD /bin/bash /usr/local/bin/start.sh