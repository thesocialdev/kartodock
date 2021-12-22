# Kartodock - Docker for GIS stacks and relatives
This repo is a prototype used to build all the needed stack technology to run [Kartotherian](https://github.com/kartotherian/kartotherian) and its repos.

## Installation
Get [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

To run the Kartotherian stack, make sure that you have [Kartotherian](https://gerrit.wikimedia.org/r/admin/projects/mediawiki/services/kartotherian) installed under `APP_CODE_PATH_HOST` environment configuration.

By default `APP_CODE_PATH_HOST=../`, the directory tree should be something like this:

```
${APP_CODE_PATH_HOST}/
├── kartodock
└──  kartotherian
```

**Beware of memory constraints of your docker setup. The installation will fail with limited memory availability. See this [issue](https://github.com/thesocialdev/kartodock/issues/6) for more details.**

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
make osm ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf -H postgres-postgis'
```
The example above might take up to 30 minutes to fully setup.

WARNING: the script downloads water polygons shapefile with 539M size.

### Kartotherian config generation
In order to make Kartotherian able to access the databases, you have to generate the configs from the templates.
```
make generate_config
```

## Execution
Now you're all set! You should be able to execute tegola and generate some tiles or kartotherian to see the tiles you have generated.

```
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
- [ ] Refactor dependecy linking for packages not present in the monorepo
- [ ] Installation script
- [ ] Implement nodemon for kartotherian
- [ ] Setup oficial Wikimedia nodejs images
- [ ] Make it possible to persist generated config between executions
