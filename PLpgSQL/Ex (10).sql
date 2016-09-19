--1
CREATE VIEW emp_dep AS
SELECT nome_emp
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep;

SELECT *
FROM emp_dep
WHERE nome_dep = 'Pesquisa';

--2
SELECT e.nome_emp                 fun
     , COALESCE(c.nome_emp, '---') chefe
FROM      emp e
LEFT JOIN emp c
       ON (e.chefe = c.n_emp);

--3
SELECT nome_emp
     , ( SELECT faixa 
         FROM faixa_sal 
         WHERE f.sal BETWEEN salmin AND salmax
       )
FROM emp f

SELECT nome_emp
     , faixa     
FROM emp
   , faixa_sal
WHERE sal BETWEEN salmin AND salmax; 

--4
SELECT e.n_emp
     , e.nome_emp
     , faixa
     , e.chefe
FROM emp       e
   , faixa_sal f
   , emp       c
WHERE e.chefe = c.n_emp
  AND e.sal BETWEEN f.salmin AND f.salmax
  AND c.sal BETWEEN f.salmin AND f.salmax;

--5
CREATE VIEW sals_dep AS
SELECT n_dep
     , MIN(sal) AS min_sal
     , MAX(sal) AS max_sal
     , AVG(sal) AS avg_sal
FROM emp
GROUP BY n_dep;

SELECT *
FROM emp
WHERE (n_dep, sal) IN ( SELECT n_dep
                             , min_sal
                        FROM sals_dep
                      );

--6
CREATE VIEW min_max_sal AS
SELECT nome_emp
FROM emp
WHERE sal = ( SELECT MIN(sal) FROM emp)
   OR sal = ( SELECT MAX(sal) FROM emp);

--7
SELECT nome_emp
     , cargo
     , sal
     , rank() OVER ( PARTITION BY cargo
                     ORDER BY sal DESC
                   )
FROM emp;

--
BEGIN;

 SELECT xmin, xmax, *
 FROM dep;

 UPDATE dep
 SET local_dep = 'Z'
 WHERE n_dep = 10;
  
COMMIT;
