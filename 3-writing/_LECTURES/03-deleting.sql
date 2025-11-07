SELECT * FROM collections; -- check collection tables

-- DELETING

DELETE FROM collections 
WHERE "title" = 'Spring outing';

DELETE FROM collections 
WHERE "acquired" IS NULL;

DELETE FROM collections 
WHERE "acquired" = '';

-- multiple deletes
DELETE FROM collections
WHERE "acquired" < '1909-01-01';