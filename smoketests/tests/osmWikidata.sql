BEGIN;
CREATE TEMPORARY TABLE lago_di_garda_json (VALUES text);
COPY lago_di_garda_json FROM '/etc/kartodock/smoketests/tests/fixtures/lago_di_garda.json';
CREATE TEMPORARY TABLE strada_del_ponale_json (VALUES text);
COPY strada_del_ponale_json FROM '/etc/kartodock/smoketests/tests/fixtures/strada_del_ponale.json';
SELECT plan(8);
SELECT has_table('wikidata_relation_members');
SELECT has_table('wikidata_relation_polygon');

PREPARE geoshapes_polygon_query AS (
    SELECT id, ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326) as data
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_polygon
            WHERE wikidata IN ($$Q6414$$)
        ) combq GROUP BY id
    ) as subq
);

SELECT isnt_empty(
    'geoshapes_polygon_query',
    'Lago di Garda is imported and accessible to geoshapes query'
);

SELECT ok(
    ST_FrechetDistance(
       (SELECT ST_GeomFromGeoJSON(values::json) as geom FROM lago_di_garda_json as osm),
       (SELECT ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326) as geom
        FROM (
            SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
            FROM (
                SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
                FROM wikidata_relation_polygon
                WHERE wikidata IN ($$Q6414$$)
            ) combq GROUP BY id
        ) as geoshapes)
    ) <= 1,
    'Lago di Garda - geoshapes output is approx. to OSM original polygon'
);

SELECT ok(
    (SELECT ST_GeometryType(ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326)) as geom
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_polygon
            WHERE wikidata IN ($$Q6414$$)
        ) combq GROUP BY id
    ) as geoshapes) IN ('ST_Polygon', 'ST_MultiPolygon'),
    'Lago di Garda - geoshapes output is polygon or multi polygon'
);

PREPARE geoshapes_linestring_query AS (
    SELECT id, ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326) as data
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_members
            WHERE wikidata IN ($$Q1421686$$)
        ) combq GROUP BY id
    ) as subq
);

SELECT isnt_empty(
    'geoshapes_linestring_query',
    'Strada del Ponale is imported and accessible to geoshapes query'
);


SELECT ok(
    ST_FrechetDistance(
       (SELECT ST_GeomFromGeoJSON(values::json) as geom FROM strada_del_ponale_json as osm),
       (SELECT ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326) as geom
        FROM (
            SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
            FROM (
                SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
                FROM wikidata_relation_members
                WHERE wikidata IN ($$Q1421686$$)
            ) combq GROUP BY id
        ) as geoshapes)
    ) <= 1,
    'Strada del Ponale - geoshapes output is approx. to OSM original linestring'
);

SELECT ok(
    (SELECT ST_GeometryType(ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326)) as geom
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_members
            WHERE wikidata IN ($$Q1421686$$)
        ) combq GROUP BY id
    ) as geoshapes) IN ('ST_MultiLineString'),
    'Strada del Ponale - geoshapes output is multilinestring'
);

SELECT * FROM finish();
ROLLBACK;
