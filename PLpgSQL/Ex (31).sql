--Apaga as tabelas
DROP TABLE IF EXISTS emp CASCADE;
DROP TABLE IF EXISTS dep CASCADE;
DROP TABLE IF EXISTS faixa_sal CASCADE;
DROP TABLE IF EXISTS exemplo1 CASCADE;
DROP TABLE IF EXISTS exemplo2 CASCADE;
DROP FUNCTION IF EXISTS f_exemplo1(int);
DROP FUNCTION IF EXISTS f_exemplo2(int);

--Tabela dep
CREATE TABLE dep (
    n_dep integer,
    nome_dep varchar(20),
    local_dep varchar(30),
    PRIMARY KEY (n_dep)
);

INSERT INTO dep VALUES (10, 'Administracao', 'Campinas');
INSERT INTO dep VALUES (20, 'Pesquisa', 'Campinas');
INSERT INTO dep VALUES (30, 'Vendas', 'Sao Paulo');
INSERT INTO dep VALUES (40, 'Producao', 'Sao Paulo');

--Tabela emp
CREATE TABLE emp (
    n_emp integer,
    nome_emp varchar(30) NOT NULL,
    cargo varchar(10) NOT NULL,
    chefe integer,
    data_adm date,
    sal numeric(10,2) NOT NULL,
    com numeric(10,2),
    n_dep integer,
    PRIMARY KEY (n_emp),
    FOREIGN KEY(n_dep) REFERENCES dep(n_dep),
    CHECK (sal > 0)
);

INSERT INTO emp VALUES (103, 'Silvia', 'Analista', 110, '2003-03-17', 150000.00, NULL, 20);
INSERT INTO emp VALUES (110, 'Ubaldo', 'Diretor', 175, '2003-03-27', 300000.00, NULL, 20);
INSERT INTO emp VALUES (175, 'Pedro', 'Presidente', NULL, '2003-02-23', 500000.00, NULL, 10);
INSERT INTO emp VALUES (189, 'Rosa', 'Diretor', 175, '2003-12-21', 330000.00, 5000.00, 30);
INSERT INTO emp VALUES (201, 'Eduardo', 'Vendedor', 189, '2003-04-11', 200000.00, 3000.00, 30);
INSERT INTO emp VALUES (208, 'Sergio', 'Vendedor', 189, '2003-10-30', 150000.00, 9000.00, 30);
INSERT INTO emp VALUES (230, 'Augusta', 'Secretaria', 175, '2003-06-10', 120000.00, NULL, 10);
INSERT INTO emp VALUES (276, 'Ronaldo', 'Analista', 110, '2003-04-17', 100000.00, NULL, 20);

--Tabela faixa_sal
CREATE TABLE faixa_sal (
    faixa character(1) NOT NULL,
    salmin numeric(10,2) NOT NULL,
    salmax numeric(10,2) NOT NULL,
    PRIMARY KEY(faixa)
);

INSERT INTO faixa_sal VALUES ('A', 1.00, 99999.00);
INSERT INTO faixa_sal VALUES ('B', 100000.00, 149999.00);
INSERT INTO faixa_sal VALUES ('C', 150000.00, 199999.00);
INSERT INTO faixa_sal VALUES ('D', 200000.00, 399999.00);
INSERT INTO faixa_sal VALUES ('E', 400000.00, 800000.00);

CREATE TABLE exemplo1(
  c1 int,
  c2 int,
  c3 int,
  c4 int,
  c5 int,
  c6 int
);

CREATE TABLE exemplo2(
  c1 int,
  c2 int,
  c3 int,
  c4 int,
  c5 int
);

CREATE OR REPLACE FUNCTION f_exemplo1(maximo int)
RETURNS void AS
$$
  DECLARE
    v_c3 int := 0;
    v_c4 int := 0;
    v_c5 int := 0;
	v_c6 int := 0;
  BEGIN
    FOR i IN 0..(maximo - 1) LOOP
      IF i%10 = 0 THEN
         v_c3 := v_c3 + 10;
      END IF;

      IF i%100 = 0 THEN
         v_c4 := v_c4 + 100;
      END IF;      

      IF i%1000 = 0 THEN
         v_c5 := v_c5 + 1000;
      END IF;     
	  
      IF i%10000 = 0 THEN
         v_c6 := v_c6 + 10000;
      END IF;

      INSERT INTO exemplo1 VALUES (i, i, v_c3, v_c4, v_c5, v_c6);      
    END LOOP;

  END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_exemplo2(maximo int)
RETURNS void AS
$$
  DECLARE
    v_c3 int := 0;
    v_c4 int := 0;
    v_c5 int := 0;
  BEGIN
    FOR i IN 0..(maximo - 1) LOOP
      INSERT INTO exemplo2 VALUES ((random()*100000)::int, (random()*100000)::int, (random()*100000)::int, (random()*100000)::int, (random()*100000)::int);      
    END LOOP;

  END;
$$ LANGUAGE plpgsql;