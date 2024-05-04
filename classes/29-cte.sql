WITH posts_week_2024 AS (
	SELECT 
		DATE_TRUNC('week', p.created_at) AS weeks, 
		COUNT(DISTINCT(p.post_id)) AS number_of_posts,
		SUM(c.counter) AS total_claps,
		COUNT(*) AS number_of_claps
	FROM posts AS p
	INNER JOIN claps AS c ON c.post_id = p.post_id
	GROUP BY weeks
	ORDER BY weeks DESC
)

SELECT *
FROM posts_week_2024
WHERE weeks BETWEEN '2024-01-01' AND '2024-12-31'
AND total_claps >= 600;
