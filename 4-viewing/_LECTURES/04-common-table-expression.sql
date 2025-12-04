DROP VIEW average_book_ratings; -- drop table from 03 sql
-- CTE

-- 1st SELECT → fills the CTE
-- 2nd SELECT → uses the CTE
WITH average_book_ratings AS (
    SELECT 
        "book_id",
        "title",
        "year", 
        ROUND(AVG("rating"), 2) AS "rating"
    FROM ratings
    JOIN books 
    ON ratings."book_id" = books."id"
    GROUP BY "book_id"
)
SELECT 
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM average_book_ratings
GROUP BY "year";
