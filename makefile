############################# Useful commands for kartodock operations #############################
include .env

# Run osm-initial-import
#
# Usage: make osm \ 
# 			ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf \
#	 		-H postgres-postgis'
osm:
	docker-compose exec workspace bash -c "PGPASSWORD=secret osm-initial-import $(ARGS)"

generate_config:
	docker-compose exec kartotherian generate_config

# Cassandra Keyspace setup https://wikitech.wikimedia.org/wiki/Maps/Keyspace_Setup
keyspace_setup:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/scripts/tileshell.js --config /etc/opt/config.tilerator.docker.yaml --source /etc/opt/sources.docker.yaml"

run_tilerator:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/tilerator/server.js -c /etc/opt/config.tilerator.docker.yaml"

run_kartotherian:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/kartotherian/server.js -c /etc/opt/config.kartotherian.docker.yaml"

npm_test:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm test"

npm_audit:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm run audit"

npm_install:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm install --unsafe-perm"
	
clean:
	docker-compose exec kartotherian bash -c "./clean_node_modules.sh"

link_external:
	# TODO
	# Link external libraries for local development
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/$(PROJECT) \
			&& rm -rf /home/kartotherian/packages/$(PROJECT)/node_modules/$(DEPENDENCY) \
			&& . /.nvm/nvm.sh && nvm use 10.15.2 && npm link /home/dependencies/$(DEPENDENCY)"

install:
	# TODO
	# Check if kartotherian is installed and clone if it isn't
	# docker-compose up --build kartotherian
	# Execute (clean and?) npm install
	# Execute osm-initial-import
	# Execute generate_config
	# Execute keyspace_setup
	# Execute kartotherian monorepo tests