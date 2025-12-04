-- Demonstrates views for simplifying data access
-- Uses longlist.db

-- Finds books written by Fernanda Melchor, now using a view 
SELECT "id" 
FROM authors
WHERE "name" = 'Fernanda Melchor';

-- Finds books written by Fernanda Melchor
SELECT "book_id" 
FROM authored
WHERE "author_id" = (
    SELECT "id" 
    FROM authors
    WHERE "name" = 'Fernanda Melchor'
);

-- Finds books written by Fernanda Melchor
SELECT "title" 
FROM "books"
WHERE "id" IN (
    SELECT "book_id" 
    FROM "authored"
    WHERE "author_id" = (
        SELECT "id" 
        FROM "authors"
        WHERE "name" = 'Fernanda Melchor'
    )
);

-- faster way to do this
SELECT 
    "name", 
    "title" 
FROM authors
JOIN authored
ON authors."id" = authored."author_id" 
JOIN books
ON books."id" = authored."book_id";

-- to save the result of that query usign CREATE VIEW name AS
CREATE VIEW longlist AS 
SELECT 
    "name", 
    "title" 
FROM authors
JOIN authored
ON authors."id" = authored."author_id" 
JOIN books
ON books."id" = authored."book_id";

-- see table views longlist
SELECT * FROM longlist;