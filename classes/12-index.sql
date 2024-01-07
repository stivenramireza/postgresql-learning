SELECT *
FROM country
WHERE continent = 'Africa';

CREATE UNIQUE INDEX "unique_country_name" ON country (name);

CREATE INDEX "country_continent" ON country (continent);
