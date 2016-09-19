CREATE VIEW dep_30 AS
SELECT *
FROM emp
WHERE n_dep = 30;

SELECT * FROM dep_30;

SELECT * 
FROM dep_30
WHERE cargo = 'Diretor';

UPDATE emp
SET com = 10000
WHERE n_emp = 189;

--update na view
UPDATE dep_30
SET com = 5000
WHERE n_emp = 189;

SELECT *
FROM emp
WHERE n_emp = 189;

--Limit e offset
SELECT *
FROM emp
LIMIT 3
OFFSET 4;

--View
CREATE VIEW teste AS
SELECT cargo
     , SUM(sal) AS soma
FROM emp
GROUP BY cargo;

SELECT * FROM teste;

CREATE OR REPLACE VIEW teste AS
SELECT cargo
     , SUM(sal) AS soma
     , MIN(sal)
FROM emp
GROUP BY cargo;

CREATE OR REPLACE VIEW teste2(a, b, c) AS
SELECT cargo
     , SUM(sal) AS soma
     , MIN(sal)
FROM emp
GROUP BY cargo;

--COALESCE
SELECT nome_emp
     , com
     , COALESCE(com, 0)
FROM emp;