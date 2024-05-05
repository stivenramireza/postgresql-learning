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

	RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM max_raise_2(206);

SELECT *
FROM employees
WHERE employee_id = 206;
