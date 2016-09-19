--SELECT
SELECT * FROM dep;

--INSERT
INSERT INTO dep VALUES (50, 'RH', 'Campinas');

--UPDATE
UPDATE dep
SET local_dep = 'Hortolândia'
WHERE n_dep = 50;

--DELETE
DELETE FROM dep
WHERE n_dep = 50;

--SELECT c/ WHERE
SELECT *
FROM dep
WHERE local_dep = 'Campinas';

--Funcionários que ganham mais de 150.000
SELECT * 
FROM emp
WHERE sal > 150000;

--Funcionários que ganham entre de 150.000 e 250.00
SELECT * 
FROM emp
WHERE sal >= 150000
  AND sal <= 250000;

SELECT * 
FROM emp
WHERE sal BETWEEN 150000 AND 250000;

--Listar os analistas ou vendedores
SELECT * 
FROM emp
WHERE cargo = 'Analista'
   OR cargo = 'Vendedor';

SELECT nome_emp 
FROM emp
WHERE cargo = 'Analista'
   OR cargo = 'Vendedor';

--Mostrar nome, salário e o salário acrescido de 10%
SELECT nome_emp
     , sal
     , sal * 1.1 sal_10
FROM emp;

--Nome concatenado com o Cargo
SELECT nome_emp || cargo
FROM emp;

--Mostrar os funcionários 
--que ganham menos do que a comissão
SELECT *
FROM emp
WHERE com > sal;

--Mostrar quanto um funcionário ganha
--salário + comissão
SELECT nome_emp
     , sal
     , com
     , COALESCE(com, 0)
     , sal + COALESCE(com, 0)
FROM emp;

--Quem não tem comissão
SELECT *
FROM emp
WHERE com IS NULL;

--Quem tem comissão
SELECT *
FROM emp
WHERE com IS NOT NULL;

--Qual é o total gasto em salários
SELECT SUM(sal)
FROM emp;

--Qual a quantidade de funcionários
SELECT COUNT(emp)
FROM emp;

SELECT COUNT(*)
FROM emp;

--Contanto as linhas não nulas
--da coluna com
SELECT COUNT(com)
FROM emp;

--Média dos salários
SELECT AVG(sal)
FROM emp;

--Maior salário
SELECT MAX(sal)
FROM emp;

--Menor salário
SELECT MIN(sal)
FROM emp;

--Média dos salários dos vendedores
SELECT AVG(sal)
FROM emp
WHERE cargo = 'Vendedor';

SELECT AVG(sal)
FROM emp
WHERE cargo = 'Analista';

SELECT AVG(sal)
FROM emp
WHERE cargo = 'Diretor';

SELECT AVG(sal)
FROM emp
WHERE cargo = 'Presidente';

--Média salarial por cargos
SELECT cargo
     , AVG(sal)
FROM emp
GROUP BY cargo;

--O nome do funcionário que tem o maior salário
SELECT nome_emp
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

--Os funcionários que ganham mais do que média salarial
SELECT nome_emp
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

--Média salarial por cargo,
--mas somente dos cargos que tenham dois
--ou mais funcionários
SELECT cargo
     , AVG(sal)
     , COUNT(*)
FROM emp
GROUP BY cargo
HAVING COUNT(*) > 1;