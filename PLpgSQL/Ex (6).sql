--Só exemplo, sem utilidade
SELECT *
FROM emp
WHERE EXISTS ( SELECT *
               FROM emp
             );

SELECT *
FROM emp
WHERE EXISTS ( SELECT *
               FROM emp
               WHERE 1 = 2
             );

--Listar os departamentos que têm funcionários
SELECT nome_dep
FROM dep
   , emp
WHERE dep.n_dep = emp.n_dep
GROUP BY nome_dep;

SELECT DISTINCT nome_dep
FROM dep
   , emp
WHERE dep.n_dep = emp.n_dep;

SELECT nome_dep
FROM dep
WHERE n_dep IN ( SELECT n_dep
                 FROM emp
                 GROUP BY n_dep
               );

SELECT nome_dep
FROM dep
WHERE n_dep IN ( SELECT DISTINCT n_dep
                 FROM emp                 
               );
           
--Exists
--Departamentos que têm funcionários
SELECT nome_dep
FROM dep
WHERE EXISTS ( SELECT 1
               FROM emp
               WHERE emp.n_dep = dep.n_dep
             );

--Departamentos que NÃO têm funcionários
SELECT nome_dep
FROM dep
WHERE NOT EXISTS ( SELECT 1
                   FROM emp
                   WHERE emp.n_dep = dep.n_dep
                 );             

--Queremos saber o nome dos funcionários
--que têm o maior salário de seu cargo
SELECT nome_emp
FROM emp e1
WHERE (sal, cargo) IN ( SELECT MAX(sal)
                             , cargo
                        FROM emp e2
                        GROUP BY cargo
                      );

SELECT nome_emp
FROM emp e1
   , ( SELECT MAX(sal) AS max_sal
            , cargo
       FROM emp e2
       GROUP BY cargo
     ) x
WHERE e1.cargo = x.cargo
  AND e1.sal   = x.max_sal;

CREATE TABLE maiores_salarios AS
SELECT MAX(sal) AS max_sal
            , cargo
       FROM emp e2
       GROUP BY cargo;

SELECT x.*
     , emp.cargo
     , emp.sal
     , emp.nome_emp
FROM maiores_salarios AS x
   , emp;

SELECT nome_emp
FROM emp e1
   , maiores_salarios AS x
WHERE e1.cargo = x.cargo
  AND e1.sal   = x.max_sal;

--Nome do diretor que ganha o maior salário!
--Deu ruim!
SELECT nome_emp
     , sal
     , cargo
FROM emp
WHERE sal = ( SELECT MAX(sal)
              FROM emp
              WHERE cargo = 'Analista'
            );

SELECT nome_emp
     , sal
     , cargo
FROM emp
WHERE sal = ( SELECT MAX(sal)
              FROM emp
              WHERE cargo = 'Analista'
            )
  AND cargo = 'Analista';          

--Funcionários com o maior salário
--de seus cargos
SELECT nome_emp
     , sal
     , cargo
FROM emp e1
WHERE sal = ( SELECT MAX(sal)
              FROM emp e2
              WHERE e2.cargo = e1.cargo
            );

--Funcionários que ganham
--o menor salário de cada departamento
SELECT nome_emp
FROM emp
WHERE (n_dep, sal) IN ( SELECT n_dep
                             , MIN(sal)
                        FROM emp
                        GROUP BY n_dep
                      );

SELECT nome_emp
     , sal
     , cargo
FROM emp e1
WHERE sal = ( SELECT MIN(sal)
              FROM emp e2
              WHERE e2.n_dep = e1.n_dep
            );

--O nome dos funcionários
--que ganham mais do que
--a média salarial
--de seus departamentos
SELECT nome_emp
FROM emp e1
WHERE sal > ( SELECT AVG(sal)
              FROM emp e2
              WHERE e1.n_dep = e2.n_dep
            );

SELECT nome_emp
FROM emp   
   , ( SELECT AVG(sal) AS avg_sal
            , n_dep 
       FROM emp e2
       GROUP BY n_dep
     ) x
WHERE emp.n_dep = x.n_dep
  AND emp.sal   > x.avg_sal;