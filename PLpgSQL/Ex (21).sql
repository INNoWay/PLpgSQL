--Departamentos que têm funcionários
SELECT DISTINCT dep.*
FROM dep
   , emp
WHERE dep.n_dep = emp.n_dep;

--Com subconsulta
SELECT *
FROM dep
WHERE n_dep IN ( SELECT n_dep
                 FROM emp
               );

--Subconsulta correlacionada
SELECT *
FROM dep
WHERE EXISTS ( SELECT 1
               FROM emp
               WHERE dep.n_dep = emp.n_dep
             );

--Departamentos que não têm funcionário
SELECT *
FROM dep
WHERE n_dep NOT IN ( SELECT n_dep
                     FROM emp
                   );

SELECT *
FROM dep
WHERE NOT EXISTS ( SELECT 1
                   FROM emp
                   WHERE dep.n_dep = emp.n_dep
                 );  

--Nome do funcionário com o maior salário
--de cada cargo

--Só mostrando
SELECT nome_emp
     , cargo
     , sal
FROM emp
ORDER BY cargo
       , sal DESC;

SELECT *
FROM emp
WHERE (cargo, sal) IN ( SELECT cargo
                             , MAX(sal)
                        FROM emp
                        GROUP BY cargo
                      );

SELECT *
FROM emp e1
WHERE sal = ( SELECT MAX(sal)
              FROM emp e2
              WHERE e1.cargo = e2.cargo
            );

SELECT emp.nome_emp
     , emp.sal
     , emp.cargo
FROM emp
   , ( SELECT MAX(sal) AS max_sal
            , cargo
       FROM emp
       GROUP BY cargo
     ) x
WHERE x.max_sal = emp.sal
  AND x.cargo   = emp.cargo;

--Será que a Sílvia ganha mais do que 
--todo mundo?
SELECT *
FROM emp
WHERE n_emp = 103
  AND sal   > ALL (SELECT sal FROM emp);

SELECT *
FROM emp
WHERE n_emp = 103
  AND sal   >= (SELECT MAX(sal) FROM emp);