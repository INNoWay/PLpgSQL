--Criando uma SEQUENCE
CREATE SEQUENCE seq;

--Obtendo dados (info) da sequence
SELECT * FROM seq;

--Rodando a sequence
SELECT nextval('seq');

CREATE SEQUENCE seq2 INCREMENT BY 2;

SELECT nextval('seq2');

CREATE SEQUENCE seq3 INCREMENT BY 1 MAXVALUE 10;

SELECT nextval('seq3');

--Teste
CREATE TABLE aluno(
  codigo int PRIMARY KEY,
  nome varchar(100)
);

CREATE SEQUENCE seq_aluno;

INSERT INTO aluno VALUES (nextval('seq_aluno'), 'Teste');
SELECT * FROM aluno;
INSERT INTO aluno VALUES (nextval('seq_aluno'), 'Teste');
SELECT * FROM aluno;

SELECT currval('seq_aluno');

SELECT setval('seq_aluno', 100);

INSERT INTO aluno VALUES (nextval('seq_aluno'), 'Teste');
SELECT * FROM aluno;

--Erro. Viola a PK
INSERT INTO aluno VALUES (1, 'Teste');

--Funciona.
--A SEQUENCE É INDEPENDENTE DA TABELA
INSERT INTO aluno VALUES (3, 'Teste');

--Default
CREATE TABLE aluno2(
  codigo int PRIMARY KEY,
  nome varchar(100),
  cidade varchar(50) DEFAULT 'Hortolândia'
);

INSERT INTO aluno2 VALUES (1, 'Teste');
SELECT * FROM aluno2;

INSERT INTO aluno2 VALUES (2, 'Teste', 'Campinas');
SELECT * FROM aluno2;

INSERT INTO aluno2 VALUES (3, 'Teste', NULL);
SELECT * FROM aluno2;

INSERT INTO aluno2 VALUES (4, 'Teste', DEFAULT);
SELECT * FROM aluno2;

--Tipo serial
CREATE SEQUENCE seq_aluno3;

CREATE TABLE aluno3(
  codigo int PRIMARY KEY DEFAULT nextval('seq_aluno3'),
  nome varchar(100)
);

INSERT INTO aluno3 VALUES (DEFAULT, 'Teste');
SELECT * FROM aluno3;

INSERT INTO aluno3 VALUES (DEFAULT, 'Teste');
SELECT * FROM aluno3;

INSERT INTO aluno3(nome) VALUES ('Teste');
SELECT * FROM aluno3;

INSERT INTO aluno3(nome, codigo) VALUES ('Teste', DEFAULT);
SELECT * FROM aluno3;

--Tipo serial
CREATE TABLE aluno4(
  codigo serial PRIMARY KEY, --Tipo serial
  nome varchar(100)
);

--Catálogo
SELECT oid, * 
FROM pg_class
WHERE relname = 'aluno3';

SELECT * 
FROM pg_attribute
WHERE attrelid = 291188;

SELECT oid, * 
FROM pg_class
WHERE relkind = 'S';

--Visão
CREATE VIEW emp_cnt_cargo AS
SELECT cargo
     , COUNT(*)
FROM emp
GROUP BY cargo;

SELECT * FROM emp_cnt_cargo;

CREATE VIEW emp_cnt_diretor AS
SELECT * 
FROM emp_cnt_cargo
WHERE cargo = 'Diretor';