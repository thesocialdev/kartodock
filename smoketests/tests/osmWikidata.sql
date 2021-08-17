BEGIN;
SELECT plan(2);

SELECT has_table('wikidata_relation_members');

PREPARE geoshapes_query AS(
    SELECT id, ST_AsGeoJSON(ST_Transform(ST_Simplify(geometry, 0.001*sqrt(ST_Area(ST_Envelope(geometry)))), 4326)) as data
    FROM (
        SELECT id, ST_Multi(ST_Union(geometry)) AS geometry
        FROM (
            SELECT wikidata AS id, (ST_Dump(geometry)).geom AS geometry
            FROM wikidata_relation_members
            WHERE wikidata IN ($$Q6414$$)
        ) combq GROUP BY id
    ) as subq);

SELECT isnt_empty(
    'geoshapes_query',
    'Lago di Garda is imported and accessible to geoshapes query'
);

SELECT * FROM finish();
ROLLBACK;
