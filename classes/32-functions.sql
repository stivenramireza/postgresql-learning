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
