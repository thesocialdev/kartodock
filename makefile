############################# Useful commands for kartodock operations #############################
include .env

# Run osm-initial-import
#
# Usage: make osm \
# 			ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf'
osm:
	docker-compose exec workspace osm-initial-import $(ARGS) -s -H postgres-postgis

generate_config:
	docker-compose exec kartotherian generate_config

generate_config_osm2pgsql:
	docker-compose exec kartotherian-osm2pgsql generate_config

# Cassandra Keyspace setup https://wikitech.wikimedia.org/wiki/Maps/Keyspace_Setup
keyspace_setup:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/scripts/tileshell.js --config /etc/opt/config.tilerator.docker.yaml --source /etc/opt/sources.docker.yaml"

run_tilerator:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/server.js -c /etc/opt/config.tilerator.docker.yaml"

run_kartotherian:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/kartotherian/server.js -c /etc/opt/config.kartotherian.docker.yaml"

run_tilerator_osm2pgsql:
	docker-compose exec kartotherian-osm2pgsql bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/server.js -c /etc/opt/config.tilerator.docker.yaml"

run_kartotherian_osm2pgsql:
	docker-compose exec kartotherian-osm2pgsql bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/kartotherian/server.js -c /etc/opt/config.kartotherian.docker.yaml"

npm_test:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm test"

npm_install:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm install --unsafe-perm"

npm_link:
	docker-compose exec kartotherian bash -c "cd /srv/dependencies/osm-bright.tm2source && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link"
	docker-compose exec kartotherian bash -c "cd /srv/dependencies/osm-bright.tm2 && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/tilerator && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-source"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/tilerator && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-style"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/kartotherian && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-source"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/kartotherian && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-style"

clean:
	docker-compose exec kartotherian bash -c "./clean_node_modules.sh"

imposm_run:
	docker-compose exec workspace bash -c "imposm run -config /srv/kartosm/config.json" -expiretiles-zoom 15

notify_tilerator:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/scripts/tileshell.js  --config /etc/opt/config.tilerator.docker.yaml -j.fromZoom 10 -j.beforeZoom 16 -j.generatorId gen -j.storageId v4 -j.deleteEmpty -j.expdirpath /srv/expiretiles -j.expmask '(expire\.list\.*)|(\.tiles)' -j.statefile /home/kartotherian/expire.state"

install:
	# TODO
	# Check if kartotherian is installed and clone if it isn't
	# docker-compose up --build kartotherian
	# Execute (clean and?) npm install
	# Execute osm-initial-import
	# Execute generate_config
	# Execute keyspace_setup
	# Execute kartotherian monorepo tests
