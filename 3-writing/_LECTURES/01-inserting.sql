-- # INSERTING
INSERT INTO collections ("id","title","accession_number","acquired")
VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');

INSERT INTO collections ("id","title","accession_number","acquired")
VALUES (2, 'Framers working at dawn', '11.6152', '1911-08-03');

SELECT * FROM collections; -- show data

INSERT INTO collections ("title", "accession_number", "acquired")
VALUES ('Spring outing', '14.76', '1914-01-08');

-- # multiple insert
INSERT INTO collections ("title", "accession_number", "acquired")
VALUES
('Imaginative landscape', '56.496', NULL),
('Peonies and butterfly', '06.1899', '1906-01-02');