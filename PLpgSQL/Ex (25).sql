--1
CREATE VIEW emp_dep AS
SELECT nome_emp
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep;

--2
SELECT e.nome_emp
     , COALESCE(c.nome_emp, '----')
FROM      emp e
LEFT JOIN emp c
       ON (e.chefe = c.n_emp);

--3
SELECT e.nome_emp
     , f.faixa
FROM emp       e
   , faixa_sal f
WHERE e.sal >= f.salmin
  AND e.sal <= f.salmax;

--4
SELECT e.nome_emp
     , f.faixa
     , e.chefe
     , e.n_emp
FROM emp       e
   , emp       c
   , faixa_sal f
WHERE e.sal  >= f.salmin
  AND e.sal  <= f.salmax
  AND e.chefe = c.n_emp
  AND c.sal  >= f.salmin
  AND c.sal  <= f.salmax;

--Mais complicado
SELECT *
FROM emp       e
   , faixa_sal f
WHERE e.sal  >= f.salmin
  AND e.sal  <= f.salmax
  AND f.faixa = ( SELECT f2.faixa
                  FROM emp       e2
                     , faixa_sal f2
                  WHERE e2.sal >= f2.salmin
                    AND e2.sal   <= f2.salmax
                    AND e2.n_emp = e.chefe
                );
--5
DROP VIEW IF EXISTS deps;
CREATE VIEW deps AS
SELECT n_dep
     , SUM(sal) AS sum_sal
     , MIN(sal) AS min_sal
     , MAX(sal) AS max_sal
FROM emp
GROUP BY n_dep;

SELECT nome_emp
FROM emp
WHERE (n_dep, sal) IN ( SELECT n_dep
                             , min_sal 
                        FROM deps
                      )
   OR (n_dep, sal) IN ( SELECT n_dep
                             , max_sal
                        FROM deps
                      );

--6
CREATE VIEW maior_menor_sal AS
SELECT nome_emp
FROM emp
WHERE sal = ( SELECT MIN(sal) FROM emp)
   OR sal = ( SELECT MAX(sal) FROM emp);

--7
CREATE VIEW sal_cargo_rank AS
SELECT nome_emp
     , cargo
     , sal
     , rank() OVER ( PARTITION BY cargo
                     ORDER BY sal DESC
                   )
FROM emp;

--Todos que ganham o segundo maior salário
--de cada cargo
SELECT * 
FROM sal_cargo_rank
WHERE rank = 2;


--Listar os segundos maiores salários
--Se um departartamento tem somente 1 funcionário
--traz os dados desses.
SELECT * 
FROM sal_cargo_rank
WHERE rank = 2
UNION
SELECT *
FROM sal_cargo_rank
WHERE cargo IN ( SELECT cargo 
                 FROM sal_cargo_rank
                 GROUP BY cargo
                 HAVING COUNT(*) = 1
               );

--Transações
BEGIN;
  SELECT * FROM dep;

  UPDATE dep
  SET local_dep = 'XXX';

  SELECT * FROM dep;
ROLLBACK;

SELECT * FROM dep;

--
UPDATE dep
SET local_dep = 'XXX';

BEGIN;
 UPDATE dep
 SET local_dep = 'YYY';

SELECT xmin, xmax, *
FROM dep; 

COMMIT;