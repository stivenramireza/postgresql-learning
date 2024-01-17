-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

-- My solution
WITH 
	l_by_co AS (
		SELECT
			l.name AS language_name,
			l.code AS language_code,
			cou.name AS country
		FROM continent AS con
		INNER JOIN country AS cou ON cou.continent = con.code
		INNER JOIN countrylanguage AS cl ON cl.countrycode = cou.code
		INNER JOIN language AS l ON l.code = cl.languagecode
		WHERE cl.isofficial = true
		AND con.name = 'Europe'
		GROUP BY l.name, l.code, cou.name
		ORDER BY cou.name ASC
	),
	total_by_l AS (
		SELECT
			language_name,
			language_code,
			COUNT(*) AS total
		FROM l_by_co
		GROUP BY language_name, language_code
	)

SELECT
	language_name,
	language_code
FROM total_by_l
WHERE total = (
	SELECT MAX(total)
	FROM total_by_l
);

-- The professor solution
SELECT 
	COUNT(*),
	b.language,
	b.languagecode
FROM country AS a
INNER JOIN countrylanguage AS b ON a.code = b.countrycode
WHERE a.continent = 5
AND b.isofficial = true
GROUP BY b.language, b.languagecode
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)

-- My solution
WITH 
	l_by_co AS (
		SELECT
			l.name AS language_name,
			l.code AS language_code,
			cou.name AS country
		FROM continent AS con
		INNER JOIN country AS cou ON cou.continent = con.code
		INNER JOIN countrylanguage AS cl ON cl.countrycode = cou.code
		INNER JOIN language AS l ON l.code = cl.languagecode
		WHERE cl.isofficial = true
		AND con.name = 'Europe'
		GROUP BY l.name, l.code, cou.name
		ORDER BY cou.name ASC
	),
	total_by_l AS (
		SELECT
			language_name,
			language_code,
			COUNT(*) AS total
		FROM l_by_co
		GROUP BY language_name, language_code
	),
	more_spoken_language AS (
		SELECT
			language_name,
			language_code
		FROM total_by_l
		WHERE total = (
			SELECT MAX(total)
			FROM total_by_l
		)
	)

SELECT cou.name
FROM country AS cou
INNER JOIN countrylanguage AS cl ON cl.countrycode = cou.code
INNER JOIN continent AS con ON con.code = cou.continent
WHERE cl.languagecode = (
	SELECT language_code
	FROM more_spoken_language
)
AND cl.isofficial = true
AND con.name = 'Europe';

-- The professor solution
SELECT *
FROM country AS a
INNER JOIN countrylanguage AS b ON a.code = b.countrycode
WHERE a.continent = 5
AND b.isofficial = true
AND b.languagecode = 135;
