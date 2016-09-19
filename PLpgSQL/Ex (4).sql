--União
--O número de colunas nas duas ou mais
--consultas devem ser iguais.
--Os tipos de dados devem ser compatíveis.
SELECT nome_emp
FROM emp
UNION
SELECT nome_dep
FROM dep;

--erro.
--tipos de dados NÃO ompatíveis.
SELECT nome_emp
FROM emp
UNION
SELECT n_dep
FROM dep;

--UNION elimina as duplicatas
SELECT nome_emp
FROM emp
UNION
SELECT nome_emp
FROM emp;


--UNION ALL mantém as duplicatas
SELECT nome_emp
FROM emp
UNION ALL
SELECT nome_emp
FROM emp;

--Intersecção
--Os números dos departamentos
--que têm funcionários.
SELECT n_dep
FROM emp
INTERSECT
SELECT n_dep
FROM dep;

--Diferença
--Os números dos departamentos
--que não têm funcionários.
SELECT n_dep
FROM dep
EXCEPT --A sintaxe depende do SGBD
SELECT n_dep
FROM emp;

--Ordenação
--Order by
SELECT *
FROM emp
ORDER BY sal;

--Decrescente
SELECT *
FROM emp
ORDER BY sal DESC;

--
SELECT *
FROM emp
ORDER BY sal DESC
       , nome_emp;

--Subconsultas
--Funcionário com o maior salário
SELECT nome_emp
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

--O nome dos funcionários
--que têm o menor salário de cada departamento.
SELECT nome_emp
     , n_dep
     , sal
FROM emp
WHERE (sal, n_dep) IN ( SELECT MIN(sal)
                             , n_dep
                        FROM emp
                        GROUP BY n_dep
                      );

--Subconsulta correlacionada
SELECT nome_emp
     , n_dep
     , sal
FROM emp e1
WHERE sal = ( SELECT MIN(sal)
              FROM emp e2
              WHERE e1.n_dep = e2.n_dep
            );

--Subconsulta na cláusula FROM
SELECT *
FROM (SELECT *
      FROM dep
      WHERE local_dep = 'Campinas'
     ) x;

SELECT nome_emp
     , emp.n_dep
     , sal
FROM emp
   , ( SELECT MIN(sal) sal_min
            , n_dep
       FROM emp
       GROUP BY n_dep
     ) x
WHERE emp.n_dep = x.n_dep
  AND emp.sal   = x.sal_min;


SELECT nome_emp
     , emp.n_dep
     , sal
FROM emp
INNER JOIN ( SELECT MIN(sal) sal_min
                  , n_dep
             FROM emp
             GROUP BY n_dep
           ) x
	ON (    emp.n_dep = x.n_dep
            AND emp.sal   = x.sal_min
           );

--Passo a passo
CREATE TABLE dep_sal_min AS
SELECT MIN(sal) sal_min
     , n_dep
FROM emp
GROUP BY n_dep;

SELECT * 
FROM dep_sal_min;

SELECT nome_emp
     , emp.n_dep
     , sal
FROM emp
   , dep_sal_min
WHERE emp.n_dep = dep_sal_min.n_dep
  AND emp.sal   = dep_sal_min.sal_min;

SELECT nome_emp
     , emp.n_dep
     , sal
FROM emp
   , ( SELECT MIN(sal) sal_min
            , n_dep
       FROM emp
       GROUP BY n_dep
     ) dep_sal_min
WHERE emp.n_dep = dep_sal_min.n_dep
  AND emp.sal   = dep_sal_min.sal_min;

--Funcionários que trabalham
--em Campinas
SELECT *
FROM dep
WHERE local_dep = 'Campinas';

SELECT *
FROM emp
WHERE n_dep IN ( SELECT n_dep
                 FROM dep
                 WHERE local_dep = 'Campinas'
               );

SELECT *
FROM emp
   , ( SELECT n_dep
       FROM dep
       WHERE local_dep = 'Campinas'
     ) x
WHERE emp.n_dep = x.n_dep;

SELECT *
FROM emp
ORDER BY sal
OFFSET 2 LIMIT 2;