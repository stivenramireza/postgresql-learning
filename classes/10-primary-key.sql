SELECT *
FROM country
LIMIT 100;

ALTER TABLE country
ADD PRIMARY KEY (code);

SELECT *
FROM country
WHERE code = 'NLD';

DELETE
FROM country
WHERE code = 'NLD' AND code2 = 'NA';
