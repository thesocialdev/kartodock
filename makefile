############################# Useful commands for gisdock operations #############################

# Run osm-initial-import
#
# Usage: make osm \ 
# 			ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf \
#	 		-H postgres-postgis'
osm:
	docker-compose exec workspace osm-initial-import $(ARGS)
