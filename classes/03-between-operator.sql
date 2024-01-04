SELECT
	first_name,
	last_name,
	followers
FROM users
-- WHERE followers >= 4600 AND followers <= 4700
WHERE followers BETWEEN 4600 AND 4700
ORDER BY followers ASC;
