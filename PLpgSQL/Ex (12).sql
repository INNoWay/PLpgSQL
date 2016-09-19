CREATE TABLE dep_auditoria (
  usuario name,
  operacao varchar(10),
  data_hora timestamp
);

SELECT current_user;
SELECT current_timestamp;

CREATE OR REPLACE FUNCTION t_dep_auditoria()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_auditoria 
  VALUES (current_user, TG_OP, current_timestamp);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

SELECT t_dep_auditoria();

CREATE TRIGGER tg_dep_auditoria
BEFORE INSERT
ON dep
FOR EACH STATEMENT
EXECUTE PROCEDURE t_dep_auditoria();

INSERT INTO dep VALUES (50, 'RH', 'Campinas');

SELECT * FROM dep_auditoria;

SELECT * FROM dep;

BEGIN;
  INSERT INTO dep VALUES (60, 'HEY', 'Paulínia');

  SELECT * FROM dep_auditoria;

  SELECT * FROM dep;
ROLLBACK;

SELECT * FROM dep_auditoria;

SELECT * FROM dep;

--Apagar o trigger e recriar
DROP TRIGGER tg_dep_auditoria ON dep;

CREATE TRIGGER tg_dep_auditoria
BEFORE INSERT OR UPDATE OR DELETE
ON dep
FOR EACH STATEMENT
EXECUTE PROCEDURE t_dep_auditoria();

UPDATE dep
SET local_dep = 'Sumaré';

SELECT * FROM dep_auditoria;

--cópia da tabela
--independente!
CREATE TABLE copia AS SELECT COUNT(*)
                           , n_dep
                      FROM emp
                      GROUP BY n_dep;

CREATE TABLE dep_log AS SELECT * FROM dep WHERE 1=2;

SELECT * FROM dep_log;

CREATE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES (NEW.n_dep, NEW.nome_dep, NEW.local_dep);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_dep_log
BEFORE INSERT OR UPDATE
ON dep
FOR EACH ROW
EXECUTE PROCEDURE t_dep_log();

INSERT INTO dep VALUES (70, 'Logística', 'Limeira');

SELECT * FROM dep_auditoria;

SELECT * FROM dep_log;

UPDATE dep
SET local_dep = 'Limeira';

SELECT * FROM dep_auditoria;

SELECT * FROM dep_log;

ALTER TABLE dep_log ADD usuario name;
ALTER TABLE dep_log ADD data_hora timestamp;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

UPDATE dep
SET local_dep = 'Hortolândia';

SELECT * FROM dep_log;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM dep;

UPDATE dep
SET local_dep = 'Campinas';

SELECT * FROM dep_log;

SELECT * FROM dep;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  NEW.nome_dep = 'X';

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

UPDATE dep
SET nome_dep = 'Y';

SELECT * FROM dep;


CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

UPDATE dep
SET nome_dep = 'Y';

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    INSERT INTO dep_log 
    VALUES ( NEW.n_dep
           , NEW.nome_dep
           , NEW.local_dep
           , current_user
           , current_timestamp
           );
    RETURN NEW;
  END IF;
 
  INSERT INTO dep_log 
  VALUES ( OLD.n_dep
         , OLD.nome_dep
         , OLD.local_dep
         , current_user
         , current_timestamp
         );

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION t_dep_auditoria()
RETURNS trigger AS $$
BEGIN
  INSERT INTO dep_auditoria 
  VALUES (current_user, TG_OP, current_timestamp);

  IF current_user = 'postgres' THEN
    RAISE EXCEPTION 'ERRO!!!! % %', current_user, current_timestamp;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DELETE FROM dep;

SELECT * FROM dep;