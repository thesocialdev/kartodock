FROM debian:stretch

RUN apt-get update && apt-get install -y nodejs \
	nodejs-legacy \
	git \
	wget \
	# curl \
	python \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev \
    libboost-system-dev libboost-thread-dev \
	libicu-dev \
    python-dev libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff5-dev \
    libcairo2 libcairo2-dev python-cairo python-cairo-dev \
    libcairomm-1.0-1v5 libcairomm-1.0-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    git build-essential python-nose \
    libgdal-dev python-gdal \
 	&& rm -rf /var/lib/apt/lists/*

# Mapnik Dependencies
RUN wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.34.tar.bz2 && \
	tar xf harfbuzz-0.9.34.tar.bz2 && \
	rm harfbuzz-0.9.34.tar.bz2 && \
	cd harfbuzz-0.9.34 && \
	./configure && make && make install && \
	ldconfig && \
	cd ../ && \
	rm -rf harfbuzz-0.9.34

# Mapnik v3.0.20
RUN wget https://github.com/mapnik/mapnik/releases/download/v3.0.20/mapnik-v3.0.20.tar.bz2 && \
	tar xf mapnik-v3.0.20.tar.bz2 && \
	cd mapnik-v3.0.20 && \
	./configure && \
	make && make install

ENV NVM_DIR $HOME/.nvm

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
	&& . $NVM_DIR/nvm.sh && nvm install 6.11.1

COPY config.docker.yaml /etc/opt/config.docker.yaml
COPY sources.docker.yaml /etc/opt/sources.docker.yaml
COPY start.sh /usr/local/bin/start.sh

WORKDIR /home/kartotherian

CMD /bin/bash /usr/local/bin/start.sh
