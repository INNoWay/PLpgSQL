SELECT nome_emp
     , sal
     , AVG(sal) OVER (PARTITION BY n_dep)
     , sal - AVG(sal) OVER (PARTITION BY n_dep)
FROM emp;

SELECT nome_emp
     , sal
     , avg_sal
FROM emp
   , ( SELECT n_dep
            , AVG(sal) avg_sal
       FROM emp
       GROUP BY n_dep
     ) c
WHERE emp.n_dep = c.n_dep;

SELECT nome_emp
     , sal
     , rank() OVER (ORDER BY sal DESC)
FROM emp;


SELECT nome_emp
     , sal
     , dense_rank() OVER (ORDER BY sal DESC)
FROM emp;

--Segundo maior salário
SELECT *
FROM ( SELECT nome_emp
            , sal
            , dense_rank() OVER (ORDER BY sal DESC) AS rank
        FROM emp
     ) c
WHERE rank = 2;

--Segundo menor salário
SELECT *
FROM ( SELECT nome_emp
            , sal
            , dense_rank() OVER (ORDER BY sal ASC) AS rank
        FROM emp
     ) c
WHERE rank = 2;

--Rank por departamento
SELECT nome_emp
     , sal
     , n_dep
     , rank() OVER (PARTITION BY n_dep ORDER BY sal DESC)
FROM emp;


SELECT nome_emp
     , sal
     , n_dep
     , cargo
     , rank() OVER (PARTITION BY n_dep
                               , cargo
                    ORDER BY sal DESC)
FROM emp;

--Cursor
BEGIN;
DECLARE c_emp CURSOR FOR SELECT * FROM emp;

FETCH c_emp;

UPDATE emp SET sal = 100 WHERE CURRENT OF c_emp;

COMMIT;

--Correção
SELECT chefe
     , COUNT(*) 
FROM emp
GROUP BY chefe
HAVING COUNT(*) >= 3;

SELECT *
FROM ( SELECT chefe 
            , COUNT(*) AS total
       FROM emp
       GROUP BY chefe
     ) c
WHERE total >= 3;

SELECT nome_emp
FROM emp
WHERE n_emp IN ( SELECT chefe
                 FROM emp
                 GROUP BY chefe
                 HAVING COUNT(*) >= 3
               );

--2               
SELECT nome_emp
     , cargo
     , salario
     , AVG(sal) OVER (PARTITION BY cargo)
FROM emp; 

SELECT nome_emp
     , emp.cargo
     , sal
     , media_sal
FROM emp
   , ( SELECT cargo
            , AVG(sal) AS media_sal
       FROM emp
       GROUP BY cargo
     ) c
WHERE emp.cargo = c.cargo;

--3
SELECT nome_emp
     , data_adm
     , n_dep
     , rank() OVER (PARTITION BY n_dep ORDER BY data_adm)
FROM emp;

--4
SELECT nome_emp
FROM emp e1
WHERE sal > ( SELECT AVG(sal)
              FROM emp e2
              WHERE e1.n_dep = e2.n_dep
            );

SELECT nome_emp
FROM emp
   , ( SELECT n_dep
            , AVG(sal) media_sal
       FROM emp
       GROUP BY n_dep
     ) c
WHERE emp.n_dep = c.n_dep
  AND emp.sal   > media_sal;