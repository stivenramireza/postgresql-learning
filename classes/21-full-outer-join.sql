SELECT *
FROM continent;

INSERT INTO continent (name)
VALUES ('Central Asia'), ('South Asia');

-- country a (name, continent)
-- continent b (name)
SELECT
	a.name AS country,
	a.continent AS continent_code,
	b.name AS continent_name
FROM country AS a
FULL OUTER JOIN continent AS b ON b.code = a.continent
ORDER BY a.name DESC;
