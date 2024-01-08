-- Tarea con countryLanguage
SELECT *
FROM countrylanguage;

-- Crear la tabla de language
SELECT *
FROM language;

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;

ALTER SEQUENCE language_code_seq RESTART WITH 1;

-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);

-- Insertar los idiomas en la tabla language
SELECT DISTINCT(language)
FROM countrylanguage
ORDER BY language ASC;

INSERT INTO language (name)
SELECT DISTINCT(language)
FROM countrylanguage
ORDER BY language ASC;

-- Empezar con el select para confirmar lo que vamos a actualizar
SELECT
	cl.language,
	cl.languagecode,
	(
		SELECT l.name
		FROM language AS l
		WHERE l.name = cl.language
	)
FROM countrylanguage AS cl;

-- Actualizar todos los registros
UPDATE countrylanguage AS cl
SET languagecode = (
	SELECT l.code
	FROM language AS l
	WHERE l.name = cl.language
);

-- Cambiar tipo de dato en countrylanguage - languagecode por int4
ALTER TABLE countrylanguage
ALTER COLUMN languagecode TYPE INT4
USING languagecode::INTEGER;

-- Crear el foreign key y constraints de no nulo el language_code
ALTER TABLE countrylanguage
ALTER COLUMN languagecode SET NOT NULL;

ALTER TABLE countrylanguage
ADD CONSTRAINT fk_language_code
FOREIGN KEY (languagecode)
REFERENCES language (code);

-- Revisar lo creado
SELECT *
FROM countrylanguage;

SELECT *
FROM language;

SELECT
	cl.language,
	cl.languagecode,
	(
		SELECT l.name
		FROM language AS l
		WHERE l.code = cl.languagecode
	)
FROM countrylanguage AS cl;
