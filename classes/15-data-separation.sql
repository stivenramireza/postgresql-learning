SELECT DISTINCT(continent)
FROM country
ORDER BY continent ASC;

CREATE TABLE continent (
	code SERIAL NOT NULL,
	name TEXT NOT NULL,
	PRIMARY KEY (code)
);

SELECT *
FROM continent;

INSERT INTO continent (name)
SELECT DISTINCT(continent)
FROM country
ORDER BY continent ASC;

SELECT *
FROM country;

SELECT *
FROM country_bk;

INSERT INTO country_bk
SELECT * FROM country;

ALTER TABLE country
DROP CONSTRAINT country_continent_check;

SELECT
	a.name,
	a.continent,
	(
		SELECT b.code
		FROM continent AS b
		WHERE b.name = a.continent
	)
FROM country AS a;

UPDATE country AS a
SET continent = (
	SELECT b.code
	FROM continent AS b
	WHERE b.name = a.continent
);

SELECT *
FROM country;

ALTER TABLE country
ALTER COLUMN continent TYPE INT4
USING continent::INTEGER;
