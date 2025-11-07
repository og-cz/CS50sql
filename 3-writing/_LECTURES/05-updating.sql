SELECT * FROM created;

-- UPDATING
-- we want arist_id = 1 is collectio_id = 1
UPDATE created 
SET "artist_id" = (
    SELECT "id" 
    FROM artists 
    WHERE "name" = 'Li Yin'
) 
WHERE collection_id = (
    SELECT "id"
    FROM collections
    WHERE "title" = 'Farmers working at dawn'
);

-- importing csv file
.import --csv votes-05.csv votes

SELECT 
    "title", 
    COUNT("title") 
FROM votes
GROUP BY "title";

-- group by is case senstive so its not grouping it properly, which we need to clean

--  Imaginative landscape|1
--  Spring outing|1
-- Famers working at dawn|1
-- Farmers Working at Dawn|1
-- Farmers working|1
-- Farmers working at dawn|1
-- Farmers working at dawn |1
-- Farmesr working at dawn |1
-- Imaginative  landscape|1
-- Imaginative landscape|2
-- Imagintive landscape|1
-- Profusion|1
-- Profusion of flowers|3
-- SPring outing|1

-- trim
UPDATE votes
SET "title" = trim("title");

-- upper
UPDATE votes
SET "title" = upper("title");


-- typo fixing
UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FARMERS WORKING';

UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FAMERS WORKING AT DAWN';

UPDATE votes
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FARMESR WORKING AT DAWN';

-- its a bit cleaner, but what if this is a thousands of data better to use LIKE
-- GROUP BY "title";
-- FARMERS WORKING AT DAWN|6
-- IMAGINATIVE  LANDSCAPE|1
-- IMAGINATIVE LANDSCAPE|3
-- IMAGINTIVE LANDSCAPE|1
-- PROFUSION|1
-- PROFUSION OF FLOWERS|3
-- SPRING OUTING|5

-- like typo fixing
UPDATE votes
SET "title" = 'IMAGINATIVE LANDSCAPE'
WHERE "title" LIKE 'IMAGI%';

UPDATE votes
SET "title" = 'IMAGINATIVE LANDSCAPE'
WHERE "title" LIKE 'PROFUSION%';

-- OUTPUT:
-- FARMERS WORKING AT DAWN|6
-- IMAGINATIVE LANDSCAPE|9
-- SPRING OUTING|5