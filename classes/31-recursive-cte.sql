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
