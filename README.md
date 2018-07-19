# Gisdock - Docker for GIS stacks and relatives
This repo is a prototype used to build all the needed stack technology to run [Kartotherian](https://github.com/kartotherian/kartotherian) and its repos.

## Installation
Get [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installed

Run the Kartotherian stack:
```
docker-compose up kartotherian
```

### Kartotherian connection to DB tweak
At this stage, Kartotherian doesn't have configurations to deal with the Docker services properly, some changes have to be made on `data.yml` and `project.yml` on the source and style project, respectively.

## TODO
- [] Add Tilerator container
- [] Fix Kosmtik container
- [] Fix the Workspace Dockerfile to have appropriate tools to handle OSM data loading
- [] Every service should have its Dockerfile