-- CREATE TEMPORARY VIEW ...
SELECT 
    "year", 
    ROUND(AVG("rating"), 2) AS "rating"
FROM average_book_ratings
GROUP BY "year";

CREATE TEMPORARY VIEW average_ratings_by_year AS
SELECT 
    "year", 
    ROUND(AVG("rating"), 2) AS "rating"
FROM average_book_ratings
GROUP BY "year";

-- check if it exist
SELECT * FROM average_ratings_by_year;
-- but after .quit -> (average_ratings_by_year) this table will be lost, it only exist while we are running query