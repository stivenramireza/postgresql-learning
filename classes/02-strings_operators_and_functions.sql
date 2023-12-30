SELECT 
	id, 
	UPPER(name) AS upper_name,
	LOWER(name) AS lower_name,
	LENGTH(name),
	(20 * 2) AS constant,
	CONCAT('*', id, ' - ', name, '*') AS normal_barcode,
	'*' || id || ' - ' || name || '*' AS barcode,
	name
FROM users;

SELECT
	name,
	SUBSTRING(name, 0, 5),
	POSITION(' ' IN name),
	SUBSTRING(name, 0, POSITION(' ' IN name)) AS first_name,
	SUBSTRING(name, POSITION(' ' IN name) + 1) AS last_name,
	TRIM(SUBSTRING(name, POSITION(' ' IN name))) AS trimmed_last_name
FROM users;

ALTER TABLE users
ADD COLUMN first_name VARCHAR(100);

ALTER TABLE users
ADD COLUMN last_name VARCHAR(100);

SELECT *
FROM users;

UPDATE 
	users
SET 
	first_name = SUBSTRING(name, 0, POSITION(' ' IN name)), 
	last_name = SUBSTRING(name, POSITION(' ' IN name) + 1);
