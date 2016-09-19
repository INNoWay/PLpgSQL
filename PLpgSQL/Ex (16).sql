--Alias para as tabelas
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM emp AS e
   , dep AS d
WHERE e.n_dep = d.n_dep;

--Consulta com auto-relacionamento
SELECT e.nome_emp
     , c.nome_emp AS chefe
FROM emp AS e
   , emp AS c
WHERE e.chefe = c.n_emp;

--Entendendo
--Combinação de todas as linha de emp
--com todas as linha de emp (8x8 = 64 linhas!)
--A condição no WHERE restrige, que apenas
--as linhas que satisfazem chefe = n_emp
--aparecem no resultado final.
SELECT e.n_emp    AS e_n_emp
     , e.nome_emp AS e_nome_emp
     , e.chefe    AS e_chefe
     , c.n_emp    AS c_n_emp
     , c.nome_emp AS c_nome_emp
FROM emp AS e
   , emp AS c;

--Junção
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM       emp AS e
INNER JOIN dep AS d
        ON (e.n_dep = d.n_dep);

SELECT e.nome_emp
     , c.nome_emp AS chefe
FROM       emp AS e
INNER JOIN emp AS c
        ON (e.chefe = c.n_emp);

--OUTER JOIN
--Traz as linhas que têm correspondência nas
--duas tabelas, definido pela condição no ON.
--Mais as linhas que NÃO têm correspondência
--em uma das tabelas. Da direita (right) ou
--esquerda (left).
--As partes faltantes (sem correspondência),
--são preenchidas com NULL!!!
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM             emp AS e 
RIGHT OUTER JOIN dep AS d
              ON (e.n_dep = d.n_dep);

SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM            dep AS d --mundado as tabelas de posição!
LEFT OUTER JOIN emp AS e 
              ON (e.n_dep = d.n_dep);

--Testando o FULL OUTER JOIN
INSERT INTO emp VALUES ( 900
                       , 'Arnaldo'
                       , 'Secretário'
                       , 110
                       , '2015-02-23'
                       , 100000
                       , NULL
                       , NULL
                       );
--Testando LEFT com emp
--Funcionário que NÃO tem departamento.
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM            emp AS e 
LEFT OUTER JOIN dep AS d
             ON (e.n_dep = d.n_dep);                       

--Testando o FULL
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM            emp AS e 
FULL OUTER JOIN dep AS d
             ON (e.n_dep = d.n_dep);

--CROSS JOIN
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM       emp AS e 
CROSS JOIN dep AS d;

--Faz uma junção
--comparando todas as colunas de mesmo nome.
--Comparação utilizando igualdade (operador =).
SELECT nome_emp
     , e.n_dep
     , d.n_dep
     , nome_dep
FROM         emp AS e 
NATURAL JOIN dep AS d;