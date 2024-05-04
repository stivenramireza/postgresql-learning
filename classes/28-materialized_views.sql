-- Create materialized views
CREATE MATERIALIZED VIEW comments_per_week_mat AS (
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
FROM comments_per_week;

SELECT *
FROM comments_per_week_mat;

REFRESH MATERIALIZED VIEW comments_per_week_mat;

SELECT *
FROM posts
WHERE post_id = 1;

-- Rename materialized views
SELECT *
FROM posts_per_week_mat;

ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;
