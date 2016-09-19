--Junção
SELECT nome_emp
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep;

--INNER JOIN
--Só um sintaxe diferente
SELECT nome_emp
     , nome_dep
FROM       emp
INNER JOIN dep
        ON (emp.n_dep = dep.n_dep);

--Explicando o INNER JOIN
SELECT nome_emp
     , emp.n_dep
     , dep.n_dep
     , nome_dep
FROM emp
   , dep; --produto cruzado ou cartesiano
          --e aí adicionamos o WHERE (operador de seleção)
          --da álgebra relacional.

--Listar o nome do funcionário
--e de seu chefe
SELECT e.nome_emp AS nome_funcionario
     , c.nome_emp AS nome_chefe
FROM emp AS e
   , emp AS c
WHERE e.chefe = c.n_emp;

--Não está correto, pois
--o WHERE é linha a linha.
SELECT nome_emp
FROM emp
WHERE chefe = n_emp;

--Entendendo
SELECT e.nome_emp AS nome_funcionario
     , e.chefe
     , c.n_emp
     , c.nome_emp AS nome_chefe
FROM emp AS e
   , emp AS c --produto cartesiano + seleção
WHERE e.chefe = c.n_emp;   

SELECT e.nome_emp AS nome_funcionario
     , e.chefe
     , c.n_emp
     , c.nome_emp AS nome_chefe
FROM       emp AS e
INNER JOIN emp AS c --o INNER é opcional
        ON (e.chefe = c.n_emp);

--CROSS JOIN - Produto cartesiano
SELECT nome_emp
     , nome_dep
FROM       emp
CROSS JOIN dep;

--NATURAL JOIN
--Equivalente a um INNER JOIN
--utilizando as colunas de mesmo nome
--nas tabelas envolvidas
SELECT nome_emp
     , nome_dep
FROM         emp
NATURAL JOIN dep;

--OUTER JOIN
--Traz as linhas que têm correspondentes
--de acordo com a condição do ON
--MAIS as linhas que NÃO têm correspondentes
--em uma das tabelas (direita ou esquerda).
SELECT nome_emp
     , nome_dep
FROM             emp 
RIGHT OUTER JOIN dep
              ON (emp.n_dep = dep.n_dep);

SELECT nome_emp
     , nome_dep
FROM            dep
LEFT OUTER JOIN emp 
             ON (emp.n_dep = dep.n_dep);

--Inserindo um novo funcionário,
--mas sem departamento.
INSERT INTO emp VALUES ( 900
                       , 'Arnaldo'
                       , 'Secretário'
                       , 208
                       , '2015-02-23'
                       , 100000
                       , NULL
                       , NULL
                       );

SELECT nome_emp
     , COALESCE(nome_dep, '*SEM DEPARTAMENTO*')
FROM            emp
LEFT OUTER JOIN dep
             ON (emp.n_dep = dep.n_dep);

--FULL JOIN
--igual ao LEFT + RIGHT
SELECT nome_emp
     , nome_dep
FROM            emp
FULL OUTER JOIN dep
             ON (emp.n_dep = dep.n_dep);

--Estabelecendo a faixa salarial
--de um funcionário
SELECT nome_emp
     , faixa
FROM emp
   , faixa_sal
WHERE sal BETWEEN salmin AND salmax;

SELECT nome_emp
     , faixa
FROM emp
   , faixa_sal
WHERE sal >= salmin 
  AND sal <= salmax;

--Faixa salarial
--nome do funcionário
--nome do departamento
SELECT faixa
     , nome_emp
     , nome_dep
FROM faixa_sal
   , emp
   , dep
WHERE sal      >= salmin 
  AND sal      <= salmax
  AND emp.n_dep = dep.n_dep;

--Sintaxe de INNER JOIN
SELECT faixa
     , nome_emp
     , nome_dep
FROM       faixa_sal
INNER JOIN emp
        ON (    sal >= salmin 
            AND sal <= salmax
           )
INNER JOIN dep
        ON (emp.n_dep = dep.n_dep);

SELECT faixa
     , nome_emp
     , nome_dep
FROM       faixa_sal
INNER JOIN emp
        ON (    sal >= salmin 
            AND sal <= salmax
           )
RIGHT JOIN dep --usando RIGHT. A palavra OUTER é opcional.
        ON (emp.n_dep = dep.n_dep);

--No Oracle
SELECT nome_emp
     , nome_dep
FROM emp
   , dep
WHERE emp.n_dep = dep.n_dep (+); --right join  