#!/bin/bash

OSM_TYPE=$1
OSM_ID=$2
OVERPASS_URL="https://overpass-api.de/api/interpreter"
OVERPASS_QUERY="$OSM_TYPE(id:$OSM_ID);(._;>;);out meta geom;"

mkdir /etc/imposm-picker/dist

# Download OSM geometry from Overpass API
curl --data-urlencode "data=$OVERPASS_QUERY" \
      $OVERPASS_URL \
      --output /etc/imposm-picker/dist/relation.osm

# Create OSM change file
osmosis \
    --rx file="/etc/imposm-picker/dist/relation.osm" \
    --rx file="/etc/imposm-picker/base.osm" \
    --dc --wxc file="/etc/imposm-picker/dist/diff.osc.gz"
