-- ¿Cuáles son los idiomas oficiales que se hablan por continente?

-- My solution
SELECT
	DISTINCT(l.name) AS language,
	con.name AS continent
FROM continent AS con
INNER JOIN country AS cou ON cou.continent = con.code
INNER JOIN countrylanguage AS cl ON cl.countrycode = cou.code
INNER JOIN language AS l ON l.code = cl.languagecode
WHERE cl.isofficial = true
GROUP BY con.name, l.name
ORDER BY con.name ASC;

-- The professor solution
SELECT
	DISTINCT(d.name) AS language,
	c.name AS continent
FROM countrylanguage AS a
INNER JOIN country AS b ON a.countrycode = b.code
INNER JOIN continent AS c ON b.continent = c.code
INNER JOIN language AS d ON d.code = a.languagecode
WHERE a.isofficial = true
ORDER BY c.name;

-- ¿Cuáles son los idiomas oficiales que se hablan por continente?

-- My solution
SELECT
	l_by_con.continent,
	COUNT(*)
FROM (
	SELECT
		con.name AS continent,
		l.name
	FROM continent AS con
	INNER JOIN country AS cou ON cou.continent = con.code
	INNER JOIN countrylanguage AS cl ON cl.countrycode = cou.code
	INNER JOIN language AS l ON l.code = cl.languagecode
	WHERE cl.isofficial = true
	GROUP BY con.name, l.name
	ORDER BY con.name
) AS l_by_con
GROUP BY l_by_con.continent
ORDER BY COUNT(*) DESC;

-- The professor solution
SELECT
	COUNT(*),
	continent
FROM (
	SELECT
		DISTINCT(d.name) AS language,
		c.name AS continent
	FROM countrylanguage AS a
	INNER JOIN country AS b ON a.countrycode = b.code
	INNER JOIN continent AS c ON b.continent = c.code
	INNER JOIN language AS d ON d.code = a.languagecode
	WHERE a.isofficial = true
	ORDER BY c.name
) AS total
GROUP BY continent
ORDER BY COUNT(*) DESC;
