-- Functions intro
SELECT GREATEST(1, 2, 30, 5);

SELECT COALESCE(NULL, 'Hello world!');

CREATE OR REPLACE FUNCTION greet_employee(employee_name VARCHAR)
RETURNS VARCHAR
AS $$
-- DECLARE
BEGIN
	RETURN 'Hello ' || employee_name;
END;
$$
LANGUAGE plpgsql;

SELECT greet_employee('Stiven');

SELECT
	first_name,
	greet_employee(first_name)
FROM employees;

-- max_raise function
SELECT *
FROM employees;

SELECT *
FROM jobs;

SELECT
	e.employee_id,
	e.first_name,
	e.salary,
	j.max_salary,
	j.max_salary - salary AS possible_raise,
	max_raise(e.employee_id)
FROM employees AS e
INNER JOIN jobs AS j ON j.job_id = e.job_id;

CREATE OR REPLACE FUNCTION max_raise(empl_id INT)
RETURNS NUMERIC(8,2) AS $$
DECLARE 
	-- salary NUMERIC(8,2);
	-- max_salary NUMERIC(8,2);
	possible_raise NUMERIC(8,2);
BEGIN
	SELECT j.max_salary - salary INTO possible_raise
	FROM employees AS e
	INNER JOIN jobs AS j ON j.job_id = e.job_id
	WHERE e.employee_id = empl_id;

	RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT max_raise(206);

SELECT
	employee_id,
	first_name,
	max_raise(employee_id)
FROM employees;

-- max_raise_2 function
CREATE OR REPLACE FUNCTION max_raise_2(empl_id INT)
RETURNS NUMERIC(8,2) AS $$
DECLARE 
	employee_job_id INT;
	current_salary NUMERIC(8,2);
	job_max_salary NUMERIC(8,2);
	possible_raise NUMERIC(8,2);
BEGIN
	-- Take the job position and the salary
	SELECT job_id, salary INTO employee_job_id, current_salary
	FROM employees 
	WHERE employee_id = empl_id;
	
	-- Take the max salary based on his job position
	SELECT max_salary INTO job_max_salary
	FROM jobs
	WHERE job_id = employee_job_id;

	-- Calculations
	possible_raise = job_max_salary - current_salary;

	IF (possible_raise < 0) THEN
		RAISE EXCEPTION 'Person with salary greater than max_salary: %', empl_id;
		-- possible_raise = 0;
	END IF;

	RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM max_raise_2(206);

SELECT
	employee_id,
	first_name,
	salary,
	max_raise_2(employee_id)
FROM employees
WHERE employee_id = 206;

-- max_raise_3 function
CREATE OR REPLACE FUNCTION max_raise_3(empl_id INT)
RETURNS NUMERIC(8,2) AS $$
DECLARE 
	selected_employee employees%ROWTYPE;
	selected_job jobs%ROWTYPE;
	possible_raise NUMERIC(8,2);
BEGIN
	-- Take the job position and the salary
	SELECT *
	FROM employees INTO selected_employee
	WHERE employee_id = empl_id;
	
	-- Take the max salary based on his job position
	SELECT *
	FROM jobs INTO selected_job
	WHERE job_id = selected_employee.job_id;

	-- Calculations
	possible_raise = selected_job.max_salary - selected_employee.salary;

	IF (possible_raise < 0) THEN
		RAISE EXCEPTION 'Person with salary greater than max_salary: id: %, name: %', selected_employee.employee_id, selected_employee.first_name;
		-- possible_raise = 0;
	END IF;

	RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT
	employee_id,
	first_name,
	salary,
	max_raise_3(employee_id)
FROM employees
WHERE employee_id = 206;

-- Returns a table with a function
CREATE OR REPLACE FUNCTION country_region()
RETURNS TABLE (id CHARACTER(2), name VARCHAR(40), region VARCHAR(25))
AS $$
BEGIN
	RETURN QUERY 
	SELECT
		c.country_id,
		c.country_name,
		r.region_name
	FROM countries AS c
	INNER JOIN regions AS r ON r.region_id = c.region_id;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM country_region();
