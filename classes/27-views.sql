CREATE OR REPLACE VIEW comments_per_week AS (
	SELECT 
		DATE_TRUNC('week', p.created_at) AS weeks, 
		COUNT(DISTINCT(p.post_id)) AS number_of_posts,
		SUM(c.counter) AS total_claps,
		COUNT(*) AS number_of_claps
	FROM posts AS p
	INNER JOIN claps AS c ON c.post_id = p.post_id
	GROUP BY weeks
	ORDER BY weeks DESC
);

SELECT *
FROM posts
WHERE post_id = 1;

SELECT *
FROM comments_per_week;

DROP VIEW comments_per_week;
