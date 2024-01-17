SELECT *
FROM continent;

ALTER SEQUENCE continent_code_seq RESTART WITH 10;

INSERT INTO continent (name)
VALUES ('North Asia');
