-- Store procedures intro
CREATE OR REPLACE PROCEDURE insert_region_proc(INT, VARCHAR)
AS $$
-- DECLARE
BEGIN
	INSERT INTO regions(region_id, region_name)
	VALUES ($1, $2);

	RAISE NOTICE 'Variable 1: %, 2: %', $1, $2

	COMMIT;
	-- ROLLBACK;
END;
$$ LANGUAGE plpgsql;

CALL insert_region_proc(5, 'Central America');

SELECT *
FROM regions;

-- Create a raise history
CREATE OR REPLACE PROCEDURE controlled_raise (percentage NUMERIC) AS $$
DECLARE
	real_percentage NUMERIC(8,2);
	total_employees INT;
BEGIN
	real_percentage = percentage / 100;

	-- Save the historical records
	INSERT INTO raise_history (date, employee_id, base_salary, amount, percentage)
	SELECT 
		CURRENT_DATE,
		employee_id,
		salary,
		max_raise(employee_id) * real_percentage,
		percentage
	FROM employees;

	-- Update the employees table
	UPDATE employees
	SET salary = salary + (max_raise(employee_id) * real_percentage);

	SELECT COUNT(*) INTO total_employees
	FROM employees;

	RAISE NOTICE 'Affected % employees', total_employees

	COMMIT;

END;
$$ LANGUAGE plpgsql;

CALL controlled_raise(1);

SELECT *
FROM employees;

SELECT *
FROM raise_history;
