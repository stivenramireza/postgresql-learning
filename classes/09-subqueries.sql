SELECT SUM(total)
FROM (
	SELECT
		SUBSTRING(email, POSITION('@' IN email) + 1) AS domain,
		COUNT(*) AS total,
		'Stiven' AS name,
		25 AS age
	FROM users
	GROUP BY SUBSTRING(email, POSITION('@' IN email) + 1)
	HAVING COUNT(*) > 1
	ORDER BY COUNT(*) DESC
) AS email_domains;
