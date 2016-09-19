--1
CREATE ROLE rh LOGIN PASSWORD 'teste';

--2
GRANT INSERT, DELETE ON dep TO rh;

--3
GRANT UPDATE(sal, com) ON emp TO RH;

--4
CREATE SCHEMA rh AUTHORIZATION rh;

--5
ALTER TABLE dep SET SCHEMA rh;
ALTER TABLE emp SET SCHEMA rh;
ALTER TABLE faixa_sal SET SCHEMA rh;

SELECT * FROM rh.dep;

--Privilégio no esquema RH para teste2
GRANT USAGE ON SCHEMA rh TO teste2;
GRANT SELECT ON rh.dep TO teste2;

--Funções
CREATE FUNCTION retorna_um()
RETURNS int AS $$
  BEGIN
    RETURN 1;
  END;
$$ LANGUAGE plpgsql;

SELECT retorna_um();

CREATE FUNCTION somar(int, int)
RETURNS int AS $$
  BEGIN
    RETURN $1 + $2;
  END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION somar(n1 int, n2 int, n3 int)
RETURNS int AS $$
  BEGIN
    RETURN n1 + n2 + n3;
  END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION somar(numeric, numeric)
RETURNS numeric AS $$
  BEGIN
    RETURN $1 + $2;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION somar(numeric, numeric)
RETURNS numeric AS $$
  DECLARE
    n1 ALIAS FOR $1;
    n2 ALIAS FOR $2;
  BEGIN
    RETURN n1 + n2;
  END;
$$ LANGUAGE plpgsql;

SELECT somar(1, 2, 3);

SELECT somar(0.1, 0.3);

CREATE OR REPLACE FUNCTION soma_sub( n1 numeric
                                   , n2 numeric
                                   , OUT soma numeric
                                   , OUT sub numeric
                                   )
AS $$
  BEGIN
    soma := n1 + n2;
    sub  := n1 - n2;
  END;
$$ LANGUAGE plpgsql;

SELECT soma_sub(1, 1);

SELECT soma
     , sub
FROM soma_sub(1, 1);

REVOKE EXECUTE ON FUNCTION retorna_um() FROM public;
REVOKE EXECUTE ON FUNCTION retorna_um() FROM rh;

GRANT EXECUTE ON FUNCTION retorna_um() TO rh;

CREATE OR REPLACE FUNCTION deletar()
RETURNS int AS $$
  BEGIN
    IF current_user != 'rh' THEN
      DELETE FROM rh.emp;
    END IF;

    RETURN 1;
  END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION deletar2()
RETURNS void AS $$
  BEGIN
    IF current_user != 'rh' THEN
      DELETE FROM rh.emp;
    END IF;

  END;
$$ LANGUAGE plpgsql SECURITY DEFINER;