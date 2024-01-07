SELECT *
FROM country;

ALTER TABLE country
ADD CHECK (
	surfacearea >= 0
);

SELECT DISTINCT(continent)
FROM country;

ALTER TABLE country
ADD CHECK (
	(continent = 'Asia'::TEXT) OR
	(continent = 'South America'::TEXT) OR
	(continent = 'North America'::TEXT) OR
	(continent = 'Oceania'::TEXT) OR
	(continent = 'Antarctica'::TEXT) OR
	(continent = 'Africa'::TEXT) OR
	(continent = 'Europe'::TEXT) OR
	(continent = 'Central America'::TEXT)
);

ALTER TABLE country
DROP CONSTRAINT country_continent_check;

SELECT *
FROM country
WHERE code = 'CRI';

UPDATE country
SET continent = 'Central America'
WHERE code = 'CRI';
