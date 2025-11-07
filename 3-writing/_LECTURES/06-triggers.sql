-- TRIGGERS

CREATE TABLE transactions (                                     -- create a table of transaction
    "id" INTEGER,
    "title" TEXT,
    "action" TEXT,
    PRIMARY KEY ("id")
);

-- CREATING TRIGGER BEFORE DELETE ON
CREATE TRIGGER sell
BEFORE DELETE ON collections
FOR EACH ROW 
BEGIN 
    INSERT INTO transactions ("title", "action")
    VALUES (OLD."title", 'sold');
END;

DELETE FROM collections 
WHERE "title" = 'Profusion of flowers';

SELECT * FROM collections;
-- 1|Farmers working at dawn|11.6152|1911-08-03
-- 2|Imaginative landscape|56.496|
-- 4|Spring outing|14.76|1914-01-08
-- sqlite> SELECT * FROM transactions;
-- 1|Profusion of flowers|sold

SELECT * FROM transactions;
-- 1|Profusion of flowers|sold

-- CREATING TRIGGER AFTER INSERT 
CREATE TRIGGER buy
AFTER INSERT ON collections
FOR EACH ROW
BEGIN 
    INSERT INTO transactions ("title", "action")
    VALUES (NEW."title", 'bought');
END;

INSERT INTO collections ("title", "accession_number", "acquired")
VALUES ('Profusion of flowers', '56.247', '1956-04-12');

SELECT * FROM collections;
-- 1|Farmers working at dawn|11.6152|1911-08-03
-- 2|Imaginative landscape|56.496|
-- 4|Spring outing|14.76|1914-01-08
-- 5|Profusion of flowers|56.247|1956-04-12
SELECT * FROM transactions;
-- 1|Profusion of flowers|sold
-- 2|Profusion of flowers|bought

-- SOFT DELETIONS
ALTER TABLE collections
ADD COLUMN 
    "deleted" INTEGER DEFAULT 0;

SELECT * FROM collections;
-- 1|Farmers working at dawn|11.6152|1911-08-03|0
-- 2|Imaginative landscape|56.496||0
-- 4|Spring outing|14.76|1914-01-08|0
-- 5|Profusion of flowers|56.247|1956-04-12|0

UPDATE collections 
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';

SELECT * FROM collections WHERE deleted != 1;
-- 2|Imaginative landscape|56.496||0
-- 4|Spring outing|14.76|1914-01-08|0
-- 5|Profusion of flowers|56.247|1956-04-12|0