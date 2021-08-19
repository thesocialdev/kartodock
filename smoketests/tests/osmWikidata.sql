BEGIN;
CREATE TEMPORARY TABLE lago_di_garda_json (VALUES text);
COPY lago_di_garda_json FROM '/etc/kartodock/smoketests/tests/fixtures/lago_di_garda.json';
SELECT plan(3);
SELECT has_table('wikidata_relation_members');

PREPARE geoshapes_query AS (
    SELECT id, ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326) as data
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_members
            WHERE wikidata IN ($$Q6414$$)
        ) combq GROUP BY id
    ) as subq
);

SELECT isnt_empty(
    'geoshapes_query',
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
                FROM wikidata_relation_members
                WHERE wikidata IN ($$Q6414$$)
            ) combq GROUP BY id
        ) as geoshapes)
    ) <= 1,
    'Lago di Garda - geoshapes output is approx. to OSM original polygon'
);

SELECT * FROM finish();
ROLLBACK;
