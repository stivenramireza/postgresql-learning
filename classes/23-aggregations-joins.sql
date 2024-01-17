SELECT 
	b.name AS continent, 
	COUNT(*) AS count
FROM country AS a
INNER JOIN continent AS b ON b.code = a.continent
GROUP BY b.name
UNION
SELECT 
	b.name AS continent, 
	0 AS count
FROM country AS a
RIGHT JOIN continent AS b ON b.code = a.continent
WHERE a.continent IS NULL
GROUP BY b.name
ORDER BY count ASC;
