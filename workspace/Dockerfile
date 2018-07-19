FROM python:3.6

RUN pip install PyYAML requests psycopg2

RUN apt-get update && apt-get install -y \
	osm2pgsql \
	make


	# http://pyyaml.org/download/pyyaml/PyYAML-3.12.tar.gz
	# tar -xzvf PyYAML-3.12.tar.gz
	# rm PyYAML-3.12.tar.gz
	# cd PyYAML-3.12/
	# python setup.py install
	# python setup.py --with-libyaml install
	# python setup.py test
	# cd ../
	# rm -rf PyYAML-3.12/

# 	# #Startup
# 	# createdb ct -h localhost -U postgres

# psql -h localhost -U postgres -d ct -c 'CREATE EXTENSION postgis; CREATE EXTENSION hstore;'
# cat sql/types/*.sql | psql -h localhost -U postgres -1Xq -d ct
# # Add other osm2pgsql flags for large imports, updates, etc
# osm2pgsql -H localhost -U default -d ct --number-processes 2 --output multi --style cleartables.json /home/pbf/antarctica-latest.osm.pbf
# cat sql/post/*.sql | psql -h localhost -U postgres -1Xq -d ct

# psql -h localhost -U default -d ct -c 'CREATE SCHEMA loading;'
# ./get-external-data.py



# RUN cd /home/src/ && npm install

# RUN if [ ${POSTGRES_POPULATE_OSM_DATABASE} = true ]; then \
#     psql -U $POSTGRES_USER -d -c 'CREATE EXTENSION hstore;' && \
#     osm2pgsql --create --slim --cache 2048 --number-processes 4 -d gis -E 3857 --hstore /home/pbf/*.pbf \
# ;fi

# RUN if [ ${POSTGRES_RUN_QUERIES} = true ]; then \
# 	psql -U $POSTGRES_USER -Xqd gis -f /home/src/node_modules/postgis-vt-util/lib.sql && \
# 	psql -U $POSTGRES_USER -Xqd gis -f /home/src/sql/admin.sql && \
# 	psql -U $POSTGRES_USER -Xqd gis -f /home/src/sql/functions.sql && \
# 	psql -U $POSTGRES_USER -Xqd gis -f /home/src/sql/create-indexes.sql && \
# 	psql -U $POSTGRES_USER -Xqd gis -f /home/src/sql/names.sql && \
# 	psql -U $POSTGRES_USER -d gis -c 'select public.populate_admin();' && \
# ;fi