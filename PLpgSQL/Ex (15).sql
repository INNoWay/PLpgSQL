--SELECT com WHERE
--WHERE filtra as linhas
--equivalente ao operador de projeção da
--álgebra relacional
SELECT *
FROM dep
WHERE local_dep = 'Campinas';

--INSERT
INSERT INTO dep VALUES (50, 'RH', 'Hortolândia');

--UPDATE
UPDATE dep
SET local_dep = 'Campinas'
WHERE n_dep = 50;

--DELETE
DELETE FROM dep
WHERE n_dep = 50;

--Expressões
SELECT nome_emp
     , sal
     , sal * 1.1 AS sal_10
FROM emp;

--Listar o salário + comissão
SELECT nome_emp
     , sal
     , com 
     , sal + COALESCE(com, 0)
FROM emp;

--WHERE com expressão
SELECT * 
FROM emp
WHERE cargo = 'Analista'
   OR cargo = 'Diretor';

--WHERE com expressão
SELECT *
FROM emp
WHERE sal BETWEEN 150000 AND 300000;

SELECT *
FROM emp
WHERE sal >= 150000
  AND sal <= 300000;

--NULL
--Quem NÃO tem comissão
SELECT nome_emp
     , com
FROM emp
WHERE com IS NULL;

--quem tem comissão
SELECT nome_emp
     , com
FROM emp
WHERE com IS NOT NULL;

--Contando
--quantos valores não nulos
--eu tenho na coluna
SELECT COUNT(nome_emp)
FROM emp;

SELECT COUNT(com)
FROM emp;

--Contando as linhas
SELECT COUNT(*)
FROM emp;

--Contando quantos vendedores
SELECT COUNT(*)
FROM emp
WHERE cargo = 'Vendedor';

--Somando
SELECT SUM(sal)
FROM emp;

--Somando
SELECT SUM(sal)
FROM emp
WHERE cargo = 'Vendedor';

--Valor do maior salário?
SELECT MAX(sal)
FROM emp;

--Valor do menor salário?
SELECT MIN(sal)
FROM emp;

--Média dos salários
SELECT AVG(sal)
FROM emp;

--Maior e menor salários ao mesmo tempo
SELECT MIN(sal)
     , MAX(sal)
     , AVG(sal)
     , SUM(sal)
FROM emp;

SELECT SUM(sal)
FROM emp
WHERE cargo = 'Vendedor';

SELECT SUM(sal)
FROM emp
WHERE cargo = 'Analista';

SELECT SUM(sal)
FROM emp
WHERE cargo = 'Diretor';

SELECT SUM(sal)
FROM emp
WHERE cargo = 'Presidente';

--GROUP BY
SELECT cargo
     , SUM(sal)
FROM emp
GROUP BY cargo;

--Subconsultas
--Listar o funcionário
--com o menor salário
SELECT *
FROM emp 
WHERE sal = (SELECT MIN(sal) FROM emp);

--Listar todos que ganham mais do que a média salarial
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(sal) FROM emp);

--Listar a soma dos salários por cargos
--desde que existam pelo menos 2 pessoas no cargo
SELECT cargo
     , SUM(sal)
FROM emp
GROUP BY cargo
HAVING COUNT(*) >= 2;

--Nome do funcionário
--Nome do departamento em que ele trabalha
SELECT nome_emp
     , emp.n_dep
     , dep.n_dep
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep;

SELECT nome_emp
     , emp.n_dep
     , dep.n_dep
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep
  AND local_dep = 'Campinas'; 