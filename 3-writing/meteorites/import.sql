.mode table

.import --csv meteorites.csv meteorites_temp

UPDATE meteorites_temp
SET
    "nametype" = CASE WHEN "nametype" = '0' OR "nametype" = '' THEN NULL ELSE "nametype" END,
    "class" = CASE WHEN "class" = '0' OR "class" = '' THEN NULL ELSE "class" END,
    "mass" = CASE WHEN "mass" = '0' OR "mass" = '' THEN NULL ELSE "mass" END,
    "discovery" = CASE WHEN "discovery" = '0' OR "discovery" = ''THEN NULL ELSE "discovery" END,
    "year" = CASE WHEN "year" = '0' OR "year" = '' THEN NULL ELSE "year" END,
    "lat" = CASE WHEN "lat" = '0' OR "lat" = '' THEN NULL ELSE "lat" END,
    "long" = CASE WHEN "long" = '0' OR "long" = '' THEN NULL ELSE "long" END;

UPDATE meteorites_temp
SET
    "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);

DELETE FROM meteorites_temp
WHERE "nametype" = 'Relict';

ALTER TABLE meteorites_temp
DROP COLUMN "id";

CREATE TABLE IF NOT EXISTS meteorites (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" REAL DEFAULT NULL,
    "discovery" TEXT CHECK ("discovery" IN ('Fell', 'Found')),
    "year" INTEGER DEFAULT NULL,
    "lat" REAL DEFAULT NULL,
    "long" REAL DEFAULT NULL,
    PRIMARY KEY ("id")
);

INSERT INTO meteorites ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM meteorites_temp
ORDER BY "year" ASC, "name" ASC;

DROP TABLE meteorites_temp;
