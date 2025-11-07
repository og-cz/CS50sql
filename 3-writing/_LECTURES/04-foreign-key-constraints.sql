-- FOREIGN KEY CONSTRAINTS
DELETE FROM artists WHERE "name" = 'Unidentified artist';
-- runtime error: we cannot delete foreign key

DELETE FROM created 
WHERE "artist_id" = (
    SELECT "id" 
    FROM artists 
    WHERE "name" = 'Unidentified artist'
);F

SELECT * FROM created;

DELETE FROM artists
WHERE "name" = 'Unidentified artist';

SELECT * FROM artists;