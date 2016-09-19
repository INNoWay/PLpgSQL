CREATE VIEW dep_30 AS
SELECT *
FROM emp
WHERE n_dep = 30;

SELECT *
FROM dep_30
WHERE cargo = 'Diretor';

UPDATE emp
SET com = 10000
WHERE n_emp = 189;

SELECT *
FROM dep_30
WHERE cargo = 'Diretor';

UPDATE dep_30
SET com = 5;

SELECT *
FROM emp;

--Limit e offset
SELECT *
FROM emp
LIMIT 3
OFFSET 1;

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 2;

--Views
CREATE VIEW cargo_sal AS
SELECT cargo
     , SUM (sal) AS soma
FROM emp
GROUP BY cargo;

SELECT *
FROM cargo_sal;

CREATE VIEW cargo_sal2(cargo, x) AS
SELECT cargo
     , SUM (sal) AS soma
FROM emp
GROUP BY cargo;

SELECT * 
FROM cargo_sal2;