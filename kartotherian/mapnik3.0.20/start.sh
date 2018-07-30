#!/bin/bash

# Define NPM version
. $NVM_DIR/nvm.sh && nvm use 6.11.1

# Create Docker Config File from template
if [ ! -f /home/kartotherian/config.docker.yaml ]; then
	perl -pe 's/\$([_A-Z]+)/$ENV{$1}/g' -i /etc/opt/config.docker.yaml \
		&& cp /etc/opt/config.docker.yaml /home/kartotherian/config.docker.yaml
fi

# Create Docker Sources config from template
if [ ! -f /home/kartotherian/sources.docker.yaml ]; then
	cp /etc/opt/sources.docker.yaml /home/kartotherian/sources.docker.yaml
fi

if [ "$KARTOTHERIAN_NPM_LINK" = true ];
then
	for f in `find /home/link -maxdepth 1 -mindepth 1 -type d`;
	do
		if [ "$f" != "$KARTOTHERIAN_SKIP_LINK_PATH" ]; 
		then
			# TODO: remove package already installed in node_modules before linking
			npm link $f 
		fi
	done
fi

# Install dependencies
npm install

# If test is set it will run npm test everytime the container is started
if [ "$KARTOTHERIAN_NPM_TEST" = true ];
then
	npm test
fi

# Start Kartotherian service
if [ "$KARTOTHERIAN_NPM_START" = true ];
then
	node server.js -c config.docker.yaml
fi
