SELECT *
FROM continent;

SELECT code, name, '123'
FROM continent
WHERE name LIKE '%America'
UNION
SELECT code, name, 'Another thing'
FROM continent
WHERE code IN (3, 5)
ORDER BY name ASC;
