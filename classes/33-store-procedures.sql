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

-- user_login procedure
CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO "user" (username, password, last_login, created_at, updated_at)
VALUES ('Melissa', crypt('123456', gen_salt('bf')), NULL, NOW(), NOW());

CREATE OR REPLACE PROCEDURE user_login(user_name VARCHAR, user_password VARCHAR) AS $$
DECLARE 
	was_found BOOLEAN;
	found_user_id INT;
	are_valid_credentials BOOLEAN;
BEGIN
	SELECT COUNT(*) INTO was_found 
	FROM "user" WHERE username = user_name;

	RAISE NOTICE 'was_found: %', was_found;

	IF (was_found = false) THEN
		RAISE EXCEPTION 'User not found: %', user_name;
	END IF;

	SELECT id INTO found_user_id 
	FROM "user" WHERE username = user_name;

	SELECT COUNT(*) INTO are_valid_credentials
	FROM "user"
	WHERE id = found_user_id
	AND password = crypt(user_password, password);

	IF (are_valid_credentials = false) THEN
		INSERT INTO session_failed (user_id)
		VALUES (found_user_id);

		COMMIT;

		RAISE EXCEPTION 'Invalid credentials';
	END IF;

	UPDATE "user"
	SET last_login = NOW()
	WHERE username = user_name;

	COMMIT;

	RAISE NOTICE 'User with valid credentials: %', are_valid_credentials;
END;
$$ LANGUAGE plpgsql;

CALL user_login('Stiven', '12345');

SELECT *
FROM "user";

SELECT *
FROM session_failed;

ALTER TABLE session_failed
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES "user" (id);

SELECT *
FROM session;

ALTER TABLE session
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES "user" (id);
