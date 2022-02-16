#!/bin/bash

cp /etc/imposm/config.template.json /etc/imposm/config.json && \
  perl -pe 's/\$([_A-Z]+)/$ENV{$1}/g' -i /etc/imposm/config.json

imposm \
    diff \
    -config /etc/imposm/config.json \
    /etc/imposm-picker/dist/diff.osc.gz
