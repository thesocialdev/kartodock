BEGIN;
SELECT plan(1);

SELECT has_table('wikidata_relation_members');

SELECT * FROM finish();
ROLLBACK;
