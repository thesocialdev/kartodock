#!/bin/bash

# Create Docker Config File from template
# TODO: verify if file already exists at the volume
perl -pe 's/\$([_A-Z]+)/$ENV{$1}/g' -i /etc/opt/config.docker.yaml \
	&& cp /etc/opt/config.docker.yaml /home/kartotherian/config.docker.yaml

if [ "$KARTOTHERIAN_NPM_LINK" = true ];
then
	for f in `find /home/link -maxdepth 1 -mindepth 1 -type d`;
	do
		npm link $f 
	done
fi

# If test is set it will run npm test everytime the container is started
if [ "$KARTOTHERIAN_NPM_TEST" = true ];
then
	npm test
fi

. $NVM_DIR/nvm.sh && nvm use 6.11.1 \
&& npm install \
&& node server.js -c config.docker.yaml
