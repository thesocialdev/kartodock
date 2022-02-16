#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

imposm import -mapping /etc/kartodock/maps-config/osm-bright.tm2source/imposm_mapping.yml \
    -read /etc/kartodock/smoketests/tests/fixtures/lago_di_garda.osm.pbf  \
    -write \
    -connection "postgis: dbname=gis host=/var/run/postgresql/ prefix=NONE" \
    -deployproduction
