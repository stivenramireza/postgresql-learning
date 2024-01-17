-- Quiero que me muestren el país con más ciudades
-- Campos: total de ciudades y el nombre del país
-- usar INNER JOIN

-- My solution
WITH ci_by_co AS (
	SELECT
		co.code AS country_code,
		co.name AS country_name,
		COUNT(*) AS total
	FROM country AS co
	INNER JOIN city AS ci ON ci.countrycode = co.code
	GROUP BY co.code, co.name
)

SELECT
	country_name AS country,
	total
FROM ci_by_co
WHERE total = (
	SELECT MAX(total)
	FROM ci_by_co
);

-- The professor solution
SELECT
	COUNT(*) AS total,
	b.name AS country
FROM city AS a
INNER JOIN country AS b ON a.countrycode = b.code
GROUP BY b.name
ORDER BY COUNT(*) DESC
LIMIT 1;
