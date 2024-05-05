CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO "session" (user_id)
	VALUES (NEW.id);

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER create_session_trigger 
AFTER UPDATE ON "user"
FOR EACH ROW 
WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
EXECUTE FUNCTION create_session_log();

CALL user_login('Stiven', '123456');

SELECT *
FROM "user";

SELECT *
FROM "session";

SELECT *
FROM session_failed;
