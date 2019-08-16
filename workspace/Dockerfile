FROM python:3.6

RUN pip install PyYAML requests psycopg2

RUN apt-get update && apt-get install -y \
	osm2pgsql \
	make

COPY osm-initial-import.sh /usr/bin/osm-initial-import

RUN chmod +x /usr/bin/osm-initial-import

WORKDIR /srv