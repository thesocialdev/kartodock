# Gisdock - Docker for GIS stacks and relatives
This repo is a prototype used to build all the needed stack technology to run [Kartotherian](https://github.com/kartotherian/kartotherian) and its repos.

## Installation
Get [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/).

To run the Kartotherian stack, make sure that you have [Kartotherian](https://github.com/kartotherian/kartotherian) installed under `APP_CODE_PATH_HOST` environment configuration. Also, define which linked dependencies you want to run with Kartotherian `APP_CODE_PATH_HOST/dependencies`. On every startup, the Kartotherian docker container will link these dependencies. By default `APP_CODE_PATH_HOST=../`,  tree should be something like this:

```
${APP_CODE_PATH_HOST}/
├── gisdock
├── kartotherian
└── dependencies
    └── some-kartotherian-dependencie
```

After the setup execute the following commands: 
```
cd gisdock
cp env-example .env
docker-compose up kartotherian
```

## TODO
- [ ] Add Tilerator container
- [ ] Fix Kosmtik container
- [ ] Proper configuration to use Sources and Styles with Mapbox Studio Classic
- [ ] Remove package already installed in node_modules before linking
