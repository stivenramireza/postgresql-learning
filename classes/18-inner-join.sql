SELECT *
FROM country;

SELECT
	a.name AS country,
	b.name AS continent
FROM country AS a
INNER JOIN continent AS b ON b.code = a.continent
ORDER BY b.name ASC;
