-- Name of the table in memory
-- Fields of the table
WITH RECURSIVE countdown(val) AS (
	-- Initialization => First level o initial values
	-- VALUES(5)
	SELECT 5 AS val
	UNION
	-- Recursive query
	SELECT val - 1 
	FROM countdown 
	WHERE val > 1
)

-- Select of the fields
SELECT *
FROM countdown;

-- Organizational structure
WITH RECURSIVE bosses AS (
	-- Init
	SELECT id, name, reports_to
	FROM employees
	WHERE id = 7
	UNION
	-- Recursive
	SELECT e.id, e.name, e.reports_to
	FROM employees AS e
	INNER JOIN bosses AS b ON b.id = e.reports_to
)

SELECT *
FROM bosses;
