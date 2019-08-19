# Kartodock - Docker for GIS stacks and relatives
This repo is a prototype used to build all the needed stack technology to run [Kartotherian](https://github.com/kartotherian/kartotherian) and its repos.

## Installation
Get [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

To run the Kartotherian stack, make sure that you have [Kartotherian](https://github.com/kartotherian/kartotherian) installed under `APP_CODE_PATH_HOST` environment configuration.

By default `APP_CODE_PATH_HOST=../`, the directory tree should be something like this:

```
${APP_CODE_PATH_HOST}/
├── kartodock
└──  kartotherian
```

To start the setup execute the following commands: 
```
cd kartodock
cp env-example .env
docker-compose up kartotherian
make clean
make npm_install
```
### OSM initial import
After the container is up you need to setup you OSM DB. The osm-initial-script which execute the initial OSM import is not prepared for full planet import, you should pick a small set of the planet from the [Geofrabrik website](http://download.geofabrik.de/). Get the PBF file link from your choice and execute the following command passing it as an argument with `-p` flag, you can also identify the DB host with `-H`, the default is `postgres-postgis`:
```
make osm ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf'
```
The example above might take up to 30 minutes to fully setup.

WARNING: the script downloads water polygons shapefile with 539M size.

### Cassandra Keyspace setup
In the first load, Cassandra need to have the keyspace properly set. You can do it manually or leave it to the first execution of tilerator, both approachs works.
```
make keyspace_setup
```

### Kartotherian config generation
In order to make Kartotherian and Tilerator able to access the Databases, you have to generate the configs from the templates.
```
make generate_config
```

## Execution
Now you're all set! You should be able to execute tilerator and generate some tiles or kartotherian to see the tiles you have generated.

```
make run_tilerator
make run_kartotherian
```

## Useful scripts

To execute `npm test` inside the docker container:
```
make npm_test
```

To execute `npm install` inside the docker contianer:
```
make npm_install
```

To execute `clean_node_modules.sh` inside the docker container:
```
make clean
```


## TODO
- [ ] Fix user permissions through the Dockerfiles
- [ ] Change Cassandra container and create environment variables for authentication
- [ ] Proper configuration to use Sources and Styles with Mapbox Studio Classic
- [ ] Refactor dependecy linking for packages not present in the monorepo
- [ ] Installation script