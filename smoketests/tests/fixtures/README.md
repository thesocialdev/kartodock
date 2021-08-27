# Updating Fixtures
## OSM GeoJSON
For now, the option chosen to generate the OSM GeoJSON fixtures is to access https://overpass-turbo.eu/ and download the data from a specific Overpass query.

To download the data you need to run the query in Overpass Turbo and go to `Export -> Data -> download/copy as GeoJSON`

After that, the data needs to be manipulated so PostGIS can execute `ST_GeomFromGeoJSON`. The reason is that it can't parse a GeoJSON that isn't a fragment, see the [documentation](https://postgis.net/docs/ST_GeomFromGeoJSON.html). In practice, it means:

The original JSON downloaded from Overpass Turbo:
```json
{
  "type": "FeatureCollection",
  "generator": "overpass-ide",
  "copyright": "The data included in this document is from www.openstreetmap.org. The data is made available under ODbL.",
  "timestamp": "2021-08-19T14:23:17Z",
  "features": [
    {
      "type": "Feature",
      "properties": {
        ...
      },
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          ...
        ]
      },
      "id": "relation/8569"
    }
  ]
}
```

With the fragment extracted, will become this JSON:
```json
{
  "type":"Polygon",
  "coordinates": [
    ...
  ]}
```

**Also, and most important the JSON needs to be minified into a one line file.**

### Lago di Garda Overpass Query
```
relation["name"="Lago di Garda"];
out geom;
```

### Strada del Ponale Overpass Query
```
relation["wikidata"="Q1421686"];
out geom;
```
