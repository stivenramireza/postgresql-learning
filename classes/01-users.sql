CREATE TABLE users (
	name VARCHAR(10) UNIQUE
);

INSERT INTO users (name) 
VALUES ('Stiven'), ('Sobeida'), ('Rubén'), ('Julián'), ('Melissa1'), ('Melissa2'), ('Melissa3'), ('Melissa4');

UPDATE users
SET name = 'Alberto'
WHERE name = 'Stiven';

SELECT *
FROM users
LIMIT 2
OFFSET 2;

SELECT *
FROM users
WHERE name = 'Sobeida';

DELETE
FROM users;

SELECT *
FROM users
WHERE name LIKE 'Mel%';

SELECT *
FROM users
WHERE name LIKE '%a%';

SELECT *
FROM users
WHERE name LIKE '_elissa%';

DELETE
FROM users
WHERE name LIKE '_elissa%';

DROP TABLE users;

TRUNCATE TABLE users;
