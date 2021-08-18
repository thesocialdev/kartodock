BEGIN;
SELECT plan(6);

SELECT has_table('water');
SELECT has_table('planet_osm_polygon');

PREPARE lago_di_garda_planet_osm_polygon AS(
    SELECT osm_id FROM planet_osm_polygon WHERE osm_id = -8569
);

SELECT isnt_empty(
    'lago_di_garda_planet_osm_polygon',
    'Lake polygon successfully is imported to planet_osm_polygon (Lago di Garda)'
);

PREPARE lago_di_garda_water AS(
    SELECT osm_id FROM water WHERE osm_id = -8569
);

SELECT isnt_empty(
    'lago_di_garda_water',
    'Lake polygon successfully is imported to water (Lago di Garda)'
);

SELECT is(
    ARRAY(SELECT
          osm_id
      FROM
          water
      WHERE
      (
          "natural" = 'water'
          OR (waterway IS NOT NULL AND waterway <> '')
          OR landuse = 'reservoir'
          OR landuse = 'pond'
      ) ORDER BY osm_id)::text,
    ARRAY(SELECT
          osm_id
      FROM
          planet_osm_polygon
      WHERE (
          "natural" = 'water'
          OR (waterway IS NOT NULL AND waterway <> '')
          OR landuse = 'reservoir'
          OR landuse = 'pond'
      ) ORDER BY osm_id)::text,
    'water and planet_osm_polygon have the same output for layer_water query'
);

SELECT is(
    ARRAY(SELECT
        ST_EQUALS(w.way, p.way) as equals
    FROM
         (
            SELECT
                osm_id,
                way
            FROM water
            WHERE
            (
                "natural" = 'water'
                OR (waterway IS NOT NULL AND waterway <> '')
                OR landuse = 'reservoir'
                OR landuse = 'pond'
            )
         ) AS w
    JOIN
         (
            SELECT
                osm_id,
                way
            FROM planet_osm_polygon
            WHERE
            (
                "natural" = 'water'
                OR (waterway IS NOT NULL AND waterway <> '')
                OR landuse = 'reservoir'
                OR landuse = 'pond'
            )
         ) AS p
    ON w.osm_id = p.osm_id
    GROUP BY equals)::text,
    ARRAY[ true ]::text,
    'water and planet_osm_polygon have the sae geometries for each entry'
);

SELECT * FROM finish();
ROLLBACK;
