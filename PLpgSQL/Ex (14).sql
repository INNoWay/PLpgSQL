CREATE TABLE produto(
  cod int PRIMARY KEY,
  descricaco varchar(20) NOT NULL,
  qtde_est int,
  CHECK (qtde_est >= 0)
);

--Inserindo um produto
INSERT INTO produto VALUES (1, 'TV', 100);

--Esse comando falha, porque a qtde_est é menor do que 0
--Restrição de check
INSERT INTO produto VALUES (2, 'Ferro', -2);

--Listando todos produtos (todas as colunas '*')
SELECT * FROM produto;

CREATE TABLE produto(
  cod int PRIMARY KEY,
  descricaco varchar(20) NOT NULL,
  qtde_est int NOT NULL, --colocando restrição de NOT NULL
  CHECK (qtde_est >= 0)
);

CREATE TABLE funcionario(
  codigo int PRIMARY KEY,
  sal numeric, --salário
  com numeric, --comissão
  CHECK (com <= sal * 0.1)
);

--Testando o check acima
--200 é > 10% do salário. Erro!
INSERT INTO funcionario VALUES (1, 1000, 200);

--Testando o check acima
INSERT INTO funcionario VALUES (1, 1000, 100);
INSERT INTO funcionario VALUES (2, 10000, 500);

--Verificar os dados da tabela
SELECT * FROM funcionario;

--Conceder 10% de aumento na comissão do funcionário 2
UPDATE funcionario
SET com = com * 0.1 + com
WHERE codigo = 2;

UPDATE funcionario
SET com = com * 1.1
WHERE codigo = 2;

--Alterando a comissão do funcionário 2 para 1500
UPDATE funcionario
SET com = 1500
WHERE codigo = 2;

--Chave estrangeira
CREATE TABLE departamento(
  cod_dep int PRIMARY KEY,
  nome varchar(30),
  local varchar(20)
);

--Apagando a tabela funcionário que criamos acima.
DROP TABLE funcionario;

CREATE TABLE funcionario(
  cod_fun int PRIMARY KEY,
  nome varchar(20),
  cargo varchar(20),
  data_inicio date,
  cod_dep int,
  FOREIGN KEY (cod_dep) REFERENCES departamento(cod_dep)
);

--Cadastrando um departamento
INSERT INTO departamento VALUES (10, 'RH', 'Hortolândia');
INSERT INTO departamento VALUES (20, 'Vendas', 'Campinas');

--Cadastrando um funcionário
INSERT INTO funcionario VALUES ( 1
                               , 'João'
                               , 'Vendedor'
                               , '2010-11-03'
                               , 20
                               );

--Erro na chave estrangeira
--Dep 30 não existe
INSERT INTO funcionario VALUES ( 2
                               , 'João'
                               , 'Vendedor'
                               , '2010-11-03'
                               , 30
                               );

--Chave estrangeira composta (exemplo)
CREATE TABLE aluno( rg varchar(10),
                    uf_emissor char(2),
                    nome varchar(100),
                    PRIMARY KEY (rg, uf_emissor) ----Chave primária composta
);

--Chave estrangeira composta (exemplo)
CREATE TABLE turma(
  codigo int PRIMARY KEY,
  descricao varchar(20),
  rg varchar(10),
  uf_emissor char(2),  
  FOREIGN KEY (rg, uf_emissor) REFERENCES aluno(rg, uf_emissor)
);