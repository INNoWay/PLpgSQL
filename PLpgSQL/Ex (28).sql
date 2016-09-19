CREATE FUNCTION retorna_sal2(numero int,
                            OUT o_sal numeric,
                            OUT o_nome_emp varchar
                           ) 
AS $$
DECLARE
 v_sal  emp.sal%TYPE;
 v_nome emp.nome_emp%TYPE;
BEGIN
  SELECT sal
       , nome_emp
  INTO v_sal
     , v_nome
  FROM emp
  WHERE n_emp = numero;

  o_sal      := v_sal;
  o_nome_emp := v_nome;

END;
$$ LANGUAGE plpgsql;

CREATE OR FUNCTION retorna_emp(numero int)
RETURNS emp AS $$
DECLARE
  v_emp emp%ROWTYPE;
BEGIN
  SELECT *
  INTO v_emp
  FROM emp
  WHERE n_emp = numero;

  RETURN v_emp;

END;
$$ LANGUAGE plpgsql;

--1
CREATE FUNCTION maior_sal(v_n_dep int)
RETURNS numeric AS $$
DECLARE
  v_max_sal emp.sal%TYPE;
BEGIN
  SELECT MAX(sal)
  INTO v_max_sal
  FROM emp
  WHERE n_dep = v_n_dep;

  RETURN v_max_sal;
END;
$$ LANGUAGE plpgsql;

SELECT maior_sal(10);

SELECT nome_emp
     , n_dep
     , sal
     , sal - maior_sal(n_dep)
     , maior_sal(n_dep)
FROM emp;

SELECT nome_emp
FROM emp
WHERE sal IN (maior_sal(10));

SELECT nome_emp
FROM emp
WHERE sal = maior_sal(10);

--2
CREATE FUNCTION menor_cargo_sal(v_cargo varchar)
RETURNS numeric AS $$
DECLARE
  v_min_sal emp.sal%TYPE;
BEGIN
  SELECT MIN(sal)
  INTO v_min_sal
  FROM emp
  WHERE cargo = v_cargo;

  RETURN v_min_sal;
END;
$$ LANGUAGE plpgsql;

SELECT menor_cargo_sal('Analista');

SELECT menor_cargo_sal(cargo)
FROM emp;

--3
CREATE FUNCTION nome_chefe(v_n_emp int)
RETURNS varchar AS $$
DECLARE
  v_chefe emp.chefe%TYPE;
  v_nome_emp emp.nome_emp%TYPE;
BEGIN
  SELECT chefe
  INTO v_chefe
  FROM emp
  WHERE n_emp = v_n_emp;

  SELECT nome_emp
  INTO v_nome_emp
  FROM emp
  WHERE n_emp = v_chefe;

  RETURN v_nome_emp;
END;
$$ LANGUAGE plpgsql;

SELECT nome_chefe(103);

SELECT nome_emp
     , nome_chefe(n_emp)
FROM emp;

--outra opção para o 3
CREATE FUNCTION nome_chefe2(v_n_emp int)
RETURNS varchar AS $$
DECLARE
  v_nome_emp emp.nome_emp%TYPE;
BEGIN
  SELECT nome_emp
  INTO v_nome_emp
  FROM emp
  WHERE n_emp = ( SELECT chefe
                  FROM emp
                  WHERE n_emp = 103
                );

  RETURN v_nome_emp;
END;
$$ LANGUAGE plpgsql;

SELECT nome_chefe2(103);

--4
CREATE FUNCTION qtde_dep(v_n_dep int)
RETURNS int AS $$
DECLARE
  v_qtde int;
BEGIN
  SELECT COUNT(*)
  INTO v_qtde
  FROM emp
  WHERE n_dep = v_n_dep;

  RETURN v_qtde;
END;
$$ LANGUAGE plpgsql;

SELECT qtde_dep(30);

SELECT nome_emp
     , qtde_dep(n_dep)
FROM emp;