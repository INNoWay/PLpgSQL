SELECT emp.nome_emp
     , emp.sal
     , c.m_salarial
FROM emp
   , ( SELECT n_dep
            , AVG(sal) AS m_salarial
       FROM emp
       GROUP BY n_dep
     ) c 
WHERE emp.n_dep = c.n_dep;

--OLAP
SELECT nome_emp
     , sal
     , AVG(sal) OVER (PARTITION BY n_dep)
FROM emp;


--Função de janela
SELECT nome_emp
     , sal
     , rank() OVER (ORDER BY sal DESC)
FROM emp;

SELECT nome_emp
     , sal
     , dense_rank() OVER (ORDER BY sal DESC)
FROM emp;

SELECT nome_emp
     , sal
     , n_dep
     , dense_rank() OVER (PARTITION BY n_dep 
                          ORDER BY sal DESC)
FROM emp;

--Segundo maior salário de cada departamento.
--Utilizando subconsulta no FROM
SELECT *
FROM ( SELECT nome_emp
            , sal
            , n_dep
            , dense_rank() OVER (PARTITION BY n_dep 
                                 ORDER BY sal DESC) AS rank
       FROM emp) c
WHERE c.rank = 2;

--Cursores
BEGIN;
DECLARE c_emp CURSOR FOR SELECT * FROM emp;

FETCH c_emp;

UPDATE emp SET sal = 100 WHERE CURRENT OF c_emp;