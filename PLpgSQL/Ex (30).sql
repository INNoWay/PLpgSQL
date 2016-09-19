CREATE TABLE dep_auditoria (
  usuario name,
  operacao varchar(10),
  data_hora timestamp
);

CREATE OR REPLACE FUNCTION t_auditoria_dep()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO dep_auditoria 
  VALUES (current_user, TG_OP, current_timestamp);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_auditoria 
BEFORE INSERT OR UPDATE
ON dep FOR EACH STATEMENT
EXECUTE PROCEDURE t_auditoria_dep();

INSERT INTO dep VALUES (50, 'RH', 'Campinas');

SELECT * FROM dep_auditoria;

UPDATE dep SET local_dep = 'Campinas';

SELECT * FROM dep_auditoria;

DELETE FROM dep
WHERE n_dep = 50;

SELECT * FROM dep_auditoria;

SELECT * FROM dep;

UPDATE dep SET local_dep = 'Hortolândia';

SELECT * FROM dep;

--mesma estrutura
--mas sem as restrições
--tabelas independentes
CREATE TABLE dep_log AS SELECT * FROM dep;

DELETE FROM dep_log;

DROP TABLE dep_log;

CREATE TABLE dep_log AS SELECT * FROM dep WHERE 1=2;

CREATE FUNCTION t_dep_log()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES (NEW.n_dep, NEW.nome_dep, NEW.local_dep);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_dep_log
BEFORE INSERT OR UPDATE
ON dep
EXECUTE PROCEDURE t_dep_log();

DROP TRIGGER tg_dep_log on DEP;

CREATE TRIGGER tg_dep_log
BEFORE INSERT OR UPDATE
ON dep FOR EACH ROW
EXECUTE PROCEDURE t_dep_log();

SELECT * FROM dep_log;

UPDATE dep SET local_dep = 'Limeira';

SELECT * FROM dep_log;
SELECT * FROM dep_auditoria;

ALTER TABLE dep_log ADD usuario name;
ALTER TABLE dep_log ADD data_hora timestamp;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS TRIGGER AS $$
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

UPDATE dep SET local_dep = 'Sumaré';

SELECT * FROM dep_log;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  RETURN OLD; --CUIDADO!
END;
$$ LANGUAGE plpgsql;

UPDATE dep SET local_dep = 'Paulínia';

SELECT * FROM dep;

INSERT INTO dep VALUES (60, 'ABC', 'Teste');

SELECT * FROM dep_log;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO dep_log 
  VALUES ( NEW.n_dep
         , NEW.nome_dep
         , NEW.local_dep
         , current_user
         , current_timestamp
         );

  NEW.local_dep := 'Hortolândia'; 

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

UPDATE dep SET local_dep = 'Paulínia';

SELECT * FROM dep;

CREATE OR REPLACE FUNCTION t_dep_log()
RETURNS TRIGGER AS $$
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

CREATE OR REPLACE FUNCTION t_auditoria_dep()
RETURNS TRIGGER AS $$
DECLARE
  v_user name;
BEGIN
  INSERT INTO dep_auditoria 
  VALUES (current_user, TG_OP, current_timestamp);

  v_user :=  current_user;
  
  IF v_user = 'postgres' THEN
    RAISE EXCEPTION 'Isso é um erro! % - %', v_user , current_timestamp;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

UPDATE dep SET local_dep = 'abc';

CREATE TRIGGER tg_dep_log3
BEFORE UPDATE
ON emp FOR EACH ROW
WHEN (NEW.com <> OLD.com)
EXECUTE PROCEDURE t_dep_log();