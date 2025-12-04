-- partitioning
SELECT 
    "id",
    "title"
FROM books
WHERE "year" = 2022;

-- check inside before creating
CREATE VIEW "2022" AS
SELECT 
    "id",
    "title"
FROM books
WHERE "year" = 2022;

-- CHECK IT
SELECT * FROM "2022";

-- what if we wanna add 2021 
CREATE VIEW "2021" AS
SELECT 
    "id",
    "title"
FROM books
WHERE "year" = 2021; -- the actual partitioning