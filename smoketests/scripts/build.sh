#!/bin/bash

pbf_file_url="http://download.geofabrik.de/europe/italy-latest.osm.pbf"
regex='(.*)/(.*)$'
[[ $pbf_file_url =~ $regex ]]
download_url=${BASH_REMATCH[1]}
filename=${BASH_REMATCH[2]}

echo "starting download of PBF from ${download_url}"
cd /etc/pbf
if [ ! -f "/etc/pbf/$filename.md5" ]; then
    curl -O ${pbf_file_url}.md5
fi
if [ ! -f "/etc/pbf/$filename" ]; then
    curl -O ${pbf_file_url}
fi
echo "starting md5sum check"
md5sum -c ${filename}.md5
if [ $? -ne 0 ] ; then
    echo "Download of PBF file failed, md5sum is invalid"
    exit -1
fi

osmosis --rb /etc/pbf/italy-latest.osm.pbf \
        --bounding-box left=10.4721 bottom=45.4103 right=10.9088 top=45.9055 \
        --wb /etc/pbf/lago_di_garda.osm.pbf
