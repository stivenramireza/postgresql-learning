-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

-- My solution
SELECT
	SUM(total) AS total,
	'America' AS continent
FROM continent AS con
INNER JOIN (
	SELECT
		COUNT(*) AS total,
		con.name AS continent
	FROM country AS cou
	INNER JOIN continent AS con ON con.code = cou.continent
	WHERE con.name LIKE '%America'
	GROUP BY con.name
) AS america_con ON america_con.continent = con.name
UNION
SELECT
	COUNT(*) AS total,
	con.name AS continent
FROM country AS cou
INNER JOIN continent AS con ON con.code = cou.continent
WHERE con.name NOT LIKE '%America'
GROUP BY con.name
ORDER BY total ASC;

-- The professor solution
SELECT
	COUNT(*) AS total,
	b.name AS continent
FROM country AS a
INNER JOIN continent AS b ON a.continent = b.code
WHERE b.code NOT IN (4, 6, 8)
GROUP BY b.name
UNION
SELECT
	COUNT(*) AS total,
	'America'
FROM country AS a
INNER JOIN continent AS b ON a.continent = b.code
WHERE b.code IN (4, 6, 8)
ORDER BY total ASC;
