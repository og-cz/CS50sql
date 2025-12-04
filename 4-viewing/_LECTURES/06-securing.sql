-- securing
SELECT 
    "id",
    "origin",
    "destination",
    'Anonymous' AS "rider"
FROM rides;

CREATE VIEW analysis AS
SELECT 
    "id",
    "origin",
    "destination",
    'Anonymous' AS "rider"
FROM rides;

SELECT * FROM rides;
SELECT * FROM analysis;
