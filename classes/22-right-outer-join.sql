SELECT *
FROM continent;

SELECT
	a.name AS country,
	a.continent AS continent_code,
	b.name AS continent_name
FROM country AS a
RIGHT JOIN continent AS b ON b.code = a.continent
WHERE a.continent IS NULL;
