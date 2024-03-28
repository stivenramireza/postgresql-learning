SELECT 
	NOW(),
	CURRENT_DATE,
	CURRENT_TIME,
	DATE_PART('hours', NOW()) AS hours,
	DATE_PART('minutes', NOW()) AS minutes,
	DATE_PART('seconds', NOW()) AS seconds,
	DATE_PART('days', NOW()) AS days,
	DATE_PART('months', NOW()) AS months,
	DATE_PART('years', NOW()) AS years;

SELECT *
FROM employees
WHERE hire_date > DATE('1998-02-05')
ORDER BY hire_date DESC;

SELECT 
	MAX(hire_date) AS latest_employee,
	MIN(hire_date) AS first_employee
FROM employees;

SELECT *
FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2000-01-01'
ORDER BY hire_date DESC;

SELECT
	MAX(hire_date),
	MAX(hire_date) + INTERVAL '1 day' AS days,
	MAX(hire_date) + INTERVAL '1 month' AS months,
	MAX(hire_date) + INTERVAL '1 year' AS years,
	MAX(hire_date) + INTERVAL '1.1 years' AS years,
	MAX(hire_date) + INTERVAL '1.1 years' + INTERVAL '1 day' AS years,
	DATE_PART('year', NOW()),
	MAKE_INTERVAL(YEARS := DATE_PART('year', NOW())::INTEGER),
	MAX(hire_date) + MAKE_INTERVAL(YEARS := 23)
FROM employees;

SELECT 
	hire_date,
	MAKE_INTERVAL(YEARS := 2024 - EXTRACT(YEARS FROM hire_date)::INTEGER) AS manual,
	MAKE_INTERVAL(YEARS := DATE_PART('years', CURRENT_DATE)::INTEGER - EXTRACT(YEARS FROM hire_date)::INTEGER) AS computed
FROM employees
ORDER BY hire_date DESC;

UPDATE employees
SET hire_date = hire_date + INTERVAL '24 years';

SELECT
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN hire_date > NOW() - INTERVAL '1 year' THEN '1 year or less'
		WHEN hire_date > NOW() - INTERVAL '3 year' THEN '1 to 3 years'
		WHEN hire_date > NOW() - INTERVAL '6 year' THEN '3 to 6 years'
		ELSE '+6 years'
	END AS old_range
FROM employees
ORDER BY hire_date DESC;
