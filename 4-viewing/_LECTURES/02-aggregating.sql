-- Demonstrates views for aggregating data
-- Uses longlist.db

-- Views ratings table
SELECT 
    "book_id", 
    ROUND(AVG("rating"), 2) AS "rating"
FROM ratings
GROUP BY "book_id";

-- added title & year 
SELECT 
    "book_id", 
    "title",
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM ratings
JOIN books 
ON ratings."book_id" = books."id"
GROUP BY "book_id";

CREATE VIEW average_book_ratings AS 
SELECT 
    "book_id", 
    "title",
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM ratings
JOIN books 
ON ratings."book_id" = books."id"
GROUP BY "book_id";