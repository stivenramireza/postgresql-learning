WITH RECURSIVE counter(val) AS (
	SELECT 1 AS val
	UNION ALL
	SELECT val + 1
	FROM counter
	WHERE val < 10
)

SELECT *
FROM counter;
