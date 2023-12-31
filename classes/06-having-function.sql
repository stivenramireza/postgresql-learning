SELECT
	country,
	COUNT(*)
FROM users
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY COUNT(*) DESC;

SELECT
	country,
	COUNT(*)
FROM users
GROUP BY country
HAVING COUNT(*) BETWEEN 1 AND 5
ORDER BY COUNT(*) DESC;
