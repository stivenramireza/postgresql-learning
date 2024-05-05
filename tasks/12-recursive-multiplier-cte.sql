WITH RECURSIVE multiplier(x, y, z) AS (
	SELECT 5, 1, 5 * 1
	UNION ALL
	SELECT x, y + 1, x * (y + 1)
	FROM multiplier
	WHERE y < 10
)

SELECT *
FROM multiplier;
