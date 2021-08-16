#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

imposm import -mapping /etc/app/kartodock/workspace/mapping.yml \
    -read /etc/app/kartodock/smoketests/tests/fixtures/lago_di_garda.osm.pbf  \
    -write \
    -connection "postgis: dbname=gis host=/var/run/postgresql/ prefix=NONE"

imposm import -mapping /etc/app/kartodock/workspace/mapping.yml \
    -deployproduction \
    -connection "postgis: dbname=gis host=/var/run/postgresql/ prefix=NONE"

pg_prove /etc/app/kartodock/smoketests/tests/osmWikidata.sql

exit 0
