# Updating Fixtures

## OSM GeoJSON
For now, the option chosen to generate the OSM GeoJSON fixtures is to access https://overpass-turbo.eu/ and download the data from a specific Overpass query.

To download the data you need to run the query in Overpass Turbo and go to `Export -> Data -> download/copy as GeoJSON`

### Lago di Garda
```
relation["name"="Lago di Garda"];
out geom;
```
