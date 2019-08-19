#!/usr/bin/env bash

set -e

pbf_dir="/srv/pbf"
kartotherian_dir="/srv/kartotherian/packages/kartotherian"
postgis_vt_util_sql_lib="${kartotherian_dir}/node_modules/@kartotherian/postgis-vt-util/lib.sql"
modules_with_sql="@kartotherian/osm-bright-source @kartotherian/geoshapes"
database_host=localhost
log_file=/var/log/osm-initial-import.log
pbf_file_url=

function show_help() {
  echo "osm-initial-import -p <pbf_file_url> [-H <database_host>]"
  echo "  pbf_file_url: look for small dumps unless you want the whole world, which can take up to 30 hours processing"
  echo "  database_host: hostname of the postgresql database, default to `hostname -f`"
  echo ""
  echo ""
  echo "  example:"
  echo "      osm-initial-import \\"
  echo "        -p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf \\"
}

while getopts "d:hH:p:-:" opt; do
  case "${opt}" in
  p)  pbf_file_url="${OPTARG}"
      ;;
  h)  show_help
      exit 0
      ;;
  H)  database_host="${OPTARG}"
      ;;
  esac
done

if [ "${pbf_file_url}" == "" ] ; then
    echo "pbf file URL is mandatory (-p)"
    exit -1
fi
regex='(.*)/(.*)$'
[[ $pbf_file_url =~ $regex ]]
download_url=${BASH_REMATCH[1]}
filename=${BASH_REMATCH[2]}
function download_pbf() {
    echo "starting download of PBF from ${download_url}"
    cd ${pbf_dir}
    if [ ! -f "$pbf_dir/$filename.md5" ]; then
        curl ${proxy} -O ${pbf_file_url}.md5
    fi
    if [ ! -f "$pbf_dir/$filename" ]; then
        curl ${proxy} -O ${pbf_file_url}
    fi
    echo "starting md5sum check"
    md5sum -c ${filename}.md5
    if [ $? -ne 0 ] ; then
        echo "Download of PBF file failed, md5sum is invalid"
        exit -1
    fi
    echo "download of PBF from planet.openstreetmap.org completed"
}


function initial_osm_import() {
  echo "starting initial OSM import"
    psql -U ${POSTGRES_USER} -h ${database_host} -d ${POSTGRES_DB} -c 'CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS hstore;' && \
    osm2pgsql \
        --create --slim --cache ${WORKSPACE_MEMORY} --number-processes ${WORKSPACE_NCPU} \
        --hstore -U ${POSTGRES_USER} -H ${database_host} -d ${POSTGRES_DB} -E 3857 \
        ${pbf_dir}/${filename} 2>&1 | tee ${log_file}

  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "osm2pgsql failed to complete initial import"
    exit -1
  fi
  echo "initial OSM import completed"
}
