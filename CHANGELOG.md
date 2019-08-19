Changelog
=========

v1.0.0
------
- Introduce osm-initial-import script for setting up OSM DB similar to what WMF production uses
- Fix exact versions of postgres-postgis and cassandra
- Add makefile with kartodock operations commands
- Add statsd container to the stack
- Setup container with the proper dependencies
- Introduce generate_config script to create the proper config for kartotherian and tilerator
- Delete docker-compose.host.yml
- Remove start.sh since kartotherian now uses lerna and is much easier to handle linked packages
- Setup container with the proper dependencies
- Introduce generate_config script to create the proper config for kartotherian and tilerator
- Delete docker-compose.host.yml
- Remove start.sh since kartotherian now uses lerna and is much easier to handle linked packages
- Hygiene: remove Kosmtik since it was never used


v0.1.0
------
- Fix the Workspace Dockerfile to have appropriate tools to handle OSM data loading
- Creating a Dockerfile for every service under the stack
- Creating Workspace service to handle OSM data loading and other setup tools that might be needed
  - Still needs some work to complete
- Adding services needed to run Kartotherian stack: Redis, Cassandra, Kartotherian, PostgreSQL + PostGis with OSM data loaded
- Adding services to manipulate CartoCSS projects: Kosmtik, Mapbox Studio Classic
  - Still needs some work to complete