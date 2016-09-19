CREATE FUNCTION ExemploNext() 
RETURNS SETOF integer AS $$
BEGIN
  RETURN NEXT 1;
  RETURN NEXT 2;
  RETURN NEXT 3;
  RETURN;
END;
$$ LANGUAGE plpgsql;

select * from ExemploNext();

CREATE FUNCTION retorna_fun(v_n_dep int) 
RETURNS SETOF varchar AS $$
DECLARE
  v_nome_emp emp.nome_emp%TYPE;
BEGIN

  FOR v_nome_emp IN SELECT nome_emp 
                    FROM emp 
                    WHERE n_dep = v_n_dep
  LOOP
    RETURN NEXT v_nome_emp;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM retorna_fun(20);

CREATE OR REPLACE FUNCTION retorna_fun2(v_n_dep int) 
RETURNS SETOF emp AS $$
DECLARE
  v_emp emp%ROWTYPE;
BEGIN

  FOR v_emp IN SELECT * 
               FROM emp 
               WHERE n_dep = v_n_dep
  LOOP
    RETURN NEXT v_emp;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM retorna_fun2(10);

--1
CREATE OR REPLACE FUNCTION exp(base int, exp int) 
RETURNS int AS $$
DECLARE
  resultado int := 1;
BEGIN
  FOR i IN 1..exp LOOP
    resultado = resultado * base;
  END LOOP;

  RETURN resultado;
END;
$$ LANGUAGE plpgsql;

SELECT exp(2, 0);

--2
CREATE FUNCTION retorna_fun(v_cargo varchar) 
RETURNS SETOF varchar AS $$
DECLARE
  v_nome emp.nome_emp%TYPE;
BEGIN

  FOR v_nome IN SELECT nome_emp
                FROM emp
                WHERE cargo = v_cargo
  LOOP
    RETURN NEXT v_nome;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

--3
CREATE FUNCTION retorna_fun3(v_valor numeric) 
RETURNS SETOF varchar AS $$
DECLARE
  v_nome emp.nome_emp%TYPE;
BEGIN

  FOR v_nome IN SELECT nome_emp
                FROM emp
                WHERE com > v_valor
  LOOP
    RETURN NEXT v_nome;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM retorna_fun3(1000);

CREATE FUNCTION retorna_fun4(v_valor numeric) 
RETURNS SETOF emp AS $$
DECLARE
  v_emp emp%ROWTYPE;
BEGIN

  FOR v_emp IN SELECT *
               FROM emp
               WHERE com > v_valor
  LOOP
    RETURN NEXT v_emp;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT nome_emp, com FRom retorna_fun4(1000);

--tipo de dados
CREATE TYPE telefone AS (tel varchar(20));

CREATE TABLE aluno(
  nome varchar,
  tel telefone --tipo telefone
);

CREATE TYPE nome_com AS (nome_emp varchar, com numeric);

CREATE FUNCTION retorna_fun5(v_valor numeric) 
RETURNS SETOF nome_com AS $$
DECLARE
  v_nome_com nome_com%ROWTYPE;
BEGIN

  FOR v_nome_com IN SELECT nome_emp
                         , com
                    FROM emp
                    WHERE com > v_valor
  LOOP
    RETURN NEXT v_nome_com;
  END LOOP;

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROm retorna_fun5(1000)