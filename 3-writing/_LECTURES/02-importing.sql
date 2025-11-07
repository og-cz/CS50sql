-- prerequisite
DROP TABLE collections;

.read 02-importing.sql

CREATE TABLE collections (
	"id" INTEGER,
	"title" TEXT NOT NULL,
	"accession_number" TEXT NOT NULL UNIQUE,
	"acquired" NUMERIC,
	PRIMARY KEY("id")
);

.schema

SELECT * FROM collections; -- nothing inside

-- IMPORTING
.import --csv --skip 1 mfa-importing.csv collections

-- importing a data with no id 
.import --csv --skip 1 mfa-importing.csv temp

.schema temp -- shows it create a blank table

INSERT INTO collections ("title", "accession_number", "acquired")
SELECT "title", "accession_number", "acquired" 
FROM temp;