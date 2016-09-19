--1
CREATE OR REPLACE FUNCTION exp(base int, expoente int)
RETURNS int AS $$
DECLARE
  contador int := 0;
  res int := 1;
BEGIN

  WHILE contador < expoente
  LOOP
    res      := res * base;
    contador := contador + 1;
  END LOOP;

  RETURN res;
  
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION exp2(base int, expoente int)
RETURNS int AS $$
DECLARE
  res int := 1;
BEGIN

  FOR i IN 1..expoente LOOP
    res := base * res;
  END LOOP;

  RETURN res;
END;
$$ LANGUAGE plpgsql;

--2
CREATE OR REPLACE FUNCTION ret_nome(v_cargo varchar)
RETURNS SETOF varchar AS $$
DECLARE
  v_nome_emp emp.nome_emp%TYPE;
BEGIN

  FOR v_nome_emp IN SELECT nome_emp 
                    FROM emp 
                    WHERE cargo = v_cargo
  LOOP
    RETURN NEXT v_nome_emp;
  END LOOP; 

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM ret_nome('Analista');

--3
CREATE OR REPLACE FUNCTION ret_com(v_valor numeric)
RETURNS SETOF varchar AS $$
DECLARE
  v_nome_emp emp.nome_emp%TYPE;
BEGIN

  FOR v_nome_emp IN SELECT nome_emp 
                    FROM emp 
                    WHERE com > v_valor
  LOOP
    RETURN NEXT v_nome_emp;
  END LOOP; 

  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM ret_com(3000);


CREATE OR REPLACE FUNCTION ret_com2(v_valor numeric)
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

SELECT nome_emp, com FROM ret_com2(1000);

--tipos de dados
CREATE TYPE telefone AS (tel varchar(20));

CREATE TABLE aluno(
  nome varchar(100),
  numero telefone --tipo telefone
);

CREATE TYPE nome_com AS ( nome_emp varchar
                        , com numeric
                        );

CREATE OR REPLACE FUNCTION ret_com3(v_valor numeric)
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

SELECT * FROM ret_com3(1000);