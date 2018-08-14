FROM debian:stretch

RUN apt-get update && apt-get install -y nodejs \
	nodejs-legacy \
	git \
	wget \
	python \
    build-essential \
 	&& rm -rf /var/lib/apt/lists/*

# Backported mapnik 3.0.20 from Wikimedia Stretch
RUN printf "deb https://apt.wikimedia.org/wikimedia stretch-wikimedia main" >> /etc/apt/sources.list
RUN wget -qO - "https://wikitech.wikimedia.org/w/index.php?title=APT_repository/Stretch-Key&action=raw" | apt-key add -
RUN apt-get update && apt-get install -y -t stretch-wikimedia libmapnik3.0 libmapnik-dev mapnik-utils mapnik-doc

ENV NVM_DIR $HOME/.nvm

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash \
	&& . $NVM_DIR/nvm.sh && nvm install 6.11.1

COPY config.docker.yaml /etc/opt/config.docker.yaml
COPY sources.docker.yaml /etc/opt/sources.docker.yaml
COPY start.sh /usr/local/bin/start.sh

WORKDIR /home/kartotherian

CMD /bin/bash /usr/local/bin/start.sh
