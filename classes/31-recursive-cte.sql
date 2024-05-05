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

-- Organizational structure with limit
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
	WHERE depth < 4
)

SELECT *
FROM bosses;

-- Example without recursion
SELECT
	f.*,
	leader.name AS leader,
	follower.name AS follower
FROM followers AS f
INNER JOIN "user" AS leader ON leader.id = f.leader_id
INNER JOIN "user" AS follower ON follower.id = f.follower_id;

-- Using normal query
SELECT *
FROM followers
WHERE leader_id IN (
	SELECT follower_id
	FROM followers
	WHERE leader_id = 1
);

-- Using recursive CTE
WITH RECURSIVE suggestions AS (
	SELECT leader_id, follower_id, 1 AS depth
	FROM followers
	WHERE leader_id = 1
	UNION
	SELECT f.leader_id, f.follower_id, depth + 1
	FROM followers AS f
	INNER JOIN suggestions ON suggestions.leader_id = f.follower_id
	WHERE depth < 3
)

SELECT *
FROM suggestions;
