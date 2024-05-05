WITH RECURSIVE bosses AS (
	-- Init
	SELECT id, name, reports_to, 1 AS depth
	FROM employees
	WHERE id = 1
	UNION
	-- Recursive
	SELECT e.id, e.name, e.reports_to, depth + 1
	FROM employees AS e
	INNER JOIN bosses AS b ON b.id = e.reports_to
	WHERE depth < 6
)

SELECT
	b.name,
	e.name AS reports_to
FROM bosses AS b
LEFT JOIN employees AS e ON e.id = b.reports_to
ORDER BY b.depth;
