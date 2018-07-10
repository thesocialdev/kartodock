FROM mdillon/postgis:latest

LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

RUN apt-get update && apt-get install -y \
	osm2pgsql

RUN cd /home/src/ && npm install &&

RUN if [ ${POSTGRES_POPULATE_OSM_DATABASE} = true ]; then \
    psql -U postgres -d -c 'CREATE EXTENSION hstore;' && \
    osm2pgsql --create --slim --cache 2048 --number-processes 4 -d gis -E 3857 --hstore /home/pbf/*.pbf \
;fi

RUN if [ ${POSTGRES_RUN_QUERIES} = true ]; then \
	psql -U postgres -Xqd gis -f node_modules/postgis-vt-util/lib.sql && \
	psql -U postgres -Xqd gis -f sql/admin.sql && \
	psql -U postgres -Xqd gis -f sql/functions.sql && \
	psql -U postgres -Xqd gis -f sql/create-indexes.sql && \
	psql -U postgres -Xqd gis -f sql/names.sql && \
	psql -U postgres -d gis -c 'select populate_admin();' && \
;fi

CMD ["postgres"]

EXPOSE 5432
