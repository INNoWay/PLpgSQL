--1
CREATE ROLE rh LOGIN PASSWORD 'teste';

--2
GRANT INSERT, DELETE ON dep TO rh;

--3
GRANT UPDATE (sal, com) ON emp TO rh;

--4
CREATE SCHEMA rh AUTHORIZATION rh;

--5
ALTER TABLE dep SET SCHEMA rh;
ALTER TABLE emp SET SCHEMA rh;
ALTER TABLE faixa_sal SET SCHEMA rh;

--Exemplo de função
CREATE FUNCTION somar(n1 int, n2 int)
RETURNS int AS $$
  BEGIN
    RETURN n1 + n2;
  END;
$$ LANGUAGE plpgsql;

SELECT somar(1, 2);

CREATE FUNCTION somar(n1 numeric, n2 numeric)
RETURNS numeric AS $$
  BEGIN
    RETURN n1 + n2;
  END;
$$ LANGUAGE plpgsql;

SELECT nome_emp
     , sal
     , com
     , somar(sal, COALESCE(com, 0))
FROM emp;

CREATE OR REPLACE FUNCTION somar(n1 numeric, n2 numeric)
RETURNS numeric AS $$
  BEGIN
    RETURN n1 + n2;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION somar(n1 int, n2 int, n3 int)
RETURNS int AS $$
  BEGIN
    RETURN n1 + n2 + n3;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION somar(n1 int, n2 int, n3 int)
RETURNS int AS $$
  BEGIN
    RETURN somar(n1, n2) + n3;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION testar( n1 int
                                 , n2 int
                                 , OUT soma int
                                 , OUT sub int
                                 )
AS $$
  BEGIN
    soma := n1 + n2;
    sub  := n1 - n2;
  END;
$$ LANGUAGE plpgsql;

SELECT soma
     , sub
FROM testar(1, 2);

CREATE OR REPLACE FUNCTION bloco_declare(n1 numeric)
RETURNS numeric AS $$
  DECLARE
    indice numeric := 0.1;
  BEGIN
    RETURN n1 * indice;
  END;
$$ LANGUAGE plpgsql;

SELECT bloco_declare(1);

CREATE OR REPLACE FUNCTION f_where()
RETURNS numeric AS $$
  BEGIN
    RETURN 103;
  END;
$$ LANGUAGE plpgsql;

SELECT *
FROM emp
WHERE n_emp = f_where();

CREATE OR REPLACE FUNCTION f_teste()
RETURNS numeric AS $$
  DECLARE
    v_n_emp emp.n_emp%TYPE;
  BEGIN
    RETURN 103;
  END;
$$ LANGUAGE plpgsql;

SELECT f_teste();

CREATE OR REPLACE FUNCTION f_teste2()
RETURNS emp.n_emp%TYPE AS $$ --só recupera o tipo, mas não associa
  DECLARE
    v_n_emp emp.n_emp%TYPE;
  BEGIN
    RETURN 103;
  END;
$$ LANGUAGE plpgsql;