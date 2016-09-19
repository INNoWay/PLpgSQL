--Exemplo de União
--Não é um exemplo prático, apenas um exemplo.
--Cada consulta deve ser o mesmo número de colunas 
--e OS TIPOS DEVEM SER COMPATÍVEIS.
SELECT *
FROM emp
WHERE cargo = 'Analista'
UNION
SELECT *
FROM emp
WHERE cargo = 'Vendedor';

--erro, pois os tipos não são compatíveis
--n_emp é integer
--nome_emp é varchar
SELECT n_emp
FROM emp
UNION
SELECT nome_dep
FROM dep;

--o Union elimina as duplicatas
SELECT nome_emp
FROM emp
UNION
SELECT nome_emp
FROM emp;

--o Union ALL MANTÉM as duplicatas
SELECT nome_emp
FROM emp
UNION ALL
SELECT nome_emp
FROM emp;

--Intersecção
--O que tem em comum nos dois
SELECT n_dep
FROM dep
INTERSECT
SELECT n_dep
FROM emp;

--Diferença
--Qual número de departamento não tem funcionários
SELECT n_dep
FROM dep
EXCEPT --a sintaxe pode variar de acordo com SGBD
SELECT n_dep
FROM emp;

--Ordenando
SELECT *
FROM emp
ORDER BY nome_emp;

--Ordenar de maneira decrescente
SELECT *
FROM emp
ORDER BY sal DESC;

SELECT *
FROM emp
ORDER BY sal DESC
       , nome_emp;

--Subconsulta
--Quero saber o nome da pessoa
--que tem o maior salário
SELECT * 
FROM emp 
WHERE sal = (SELECT MAX(sal) FROM emp);

--O nome das pessoas que têm o maior
--salário por departamento
SELECT nome_emp
     , n_dep
     , sal
FROM emp
WHERE (n_dep, sal) IN ( SELECT n_dep
                             , MAX(sal) 
                        FROM emp
                        GROUP BY n_dep
                      );

--Subconsultas correlacionadas
--Nome dos funcionários
--que ganham o maior salário
--de seus departamentos
SELECT nome_emp
     , n_dep
     , sal
FROM emp e1
WHERE e1.sal = ( SELECT MAX(sal)
                 FROM emp e2
                 WHERE e1.n_dep = e2.n_dep
               );

--O nome dos funcionários
--que ganham o menor salário
--de seus cargos
SELECT nome_emp
FROM emp
WHERE (cargo, sal) IN ( SELECT cargo
                             , MIN(sal)
                        FROM emp
                        GROUP BY cargo
                      );

SELECT nome_emp
FROM emp e1
WHERE sal = ( SELECT MIN(sal)
              FROM emp e2
              WHERE e1.cargo = e2.cargo
            )
ORDER BY sal;

SELECT nome_emp
FROM emp
   , ( SELECT cargo
            , MIN(sal) AS min
       FROM emp
       GROUP BY cargo
     ) x
WHERE emp.cargo = x.cargo
  AND emp.sal   = x.min;    

--subconsulta na cláusula FROM
SELECT nome_emp
FROM emp
   , ( SELECT *
       FROM dep
       WHERE local_dep = 'Sao Paulo'
     ) x
WHERE emp.n_dep = x.n_dep;