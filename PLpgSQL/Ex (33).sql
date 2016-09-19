--1
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
     , sal
     , AVG(sal) OVER (PARTITION BY cargo)
     , sal - AVG(sal) OVER (PARTITION BY cargo)
FROM emp;

SELECT nome_emp
     , emp.cargo
     , sal
     , avg_sal
FROM emp
   , ( SELECT AVG(sal) avg_sal
            , cargo
       FROM emp
       GROUP BY cargo) c
WHERE emp.cargo = c.cargo;

--3
SELECT nome_emp
     , data_adm
     , rank() OVER (ORDER BY data_adm)
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
            , AVG(sal) avg_sal
       FROM emp
       GROUP BY n_dep
     ) c
WHERE emp.n_dep = c.n_dep
  AND emp.sal   > c.avg_sal;