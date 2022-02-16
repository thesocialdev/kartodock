#!/bin/bash

# Setup config and sources yaml templates
# Create Docker Config File from template
if [ ! -f /etc/opt/config.docker.yaml ]; then
	echo "Generating config.yaml"
	perl -pe 's/\$([_A-Z]+)/$ENV{$1}/g' -i /etc/opt/config.kartotherian.docker.template.yaml \
		&& cp /etc/opt/config.kartotherian.docker.template.yaml /etc/opt/config.kartotherian.docker.yaml
fi

echo "Generation of config files completed"