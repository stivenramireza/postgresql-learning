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
