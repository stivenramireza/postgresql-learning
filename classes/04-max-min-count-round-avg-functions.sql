SELECT 
	COUNT(*) AS total_users,
	MIN(followers) AS min_followers,
	MAX(followers) AS max_followers,
	ROUND(AVG(followers)) AS avg_followers,
	SUM(followers) / COUNT(*) AS avg_manual_followers
FROM users;
