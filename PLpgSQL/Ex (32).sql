DROP TABLE IF EXISTS medico_convenio CASCADE;
DROP TABLE IF EXISTS consulta CASCADE;
DROP TABLE IF EXISTS medico CASCADE;
DROP TABLE IF EXISTS especialidade CASCADE;
DROP TABLE IF EXISTS convenio CASCADE;
DROP TABLE IF EXISTS paciente CASCADE;

CREATE TABLE paciente(
  id_paciente int,
  nome varchar(100) NOT NULL,
  data_nascimento date,
  PRIMARY KEY (id_paciente)
);

INSERT INTO paciente VALUES (1, 'Marcos', '2000-01-03');
INSERT INTO paciente VALUES (2, 'Josefa', '1983-01-27');
INSERT INTO paciente VALUES (3, 'Mirtes', '1988-07-20');
INSERT INTO paciente VALUES (4, 'Zulmira', '1995-10-13');
INSERT INTO paciente VALUES (5, 'Breno', '1996-10-13');
INSERT INTO paciente VALUES (6, 'Silvio', '1999-11-05');

CREATE TABLE especialidade(
  id_especialidade int,
  descricao varchar(100) NOT NULL,
  PRIMARY KEY (id_especialidade)
);

INSERT INTO especialidade VALUES (1, 'Cardiologista');
INSERT INTO especialidade VALUES (2, 'Neurologista');
INSERT INTO especialidade VALUES (3, 'Clínico Geral');
INSERT INTO especialidade VALUES (4, 'Pediatra');
INSERT INTO especialidade VALUES (5, 'Geriatra');

CREATE TABLE medico(
  id_medico int,
  nome varchar(50) NOT NULL,
  id_especialidade int,
  crm varchar(100),
  PRIMARY KEY(id_medico),
  FOREIGN KEY(id_especialidade) REFERENCES especialidade(id_especialidade)
);

INSERT INTO medico VALUES (1, 'Sandra', 4, 'SP12345');
INSERT INTO medico VALUES (2, 'Murilo', 3, 'MG54321');
INSERT INTO medico VALUES (3, 'Nestor', 1, 'MG55555');
INSERT INTO medico VALUES (4, 'Norma', 2, 'RJ98765');
INSERT INTO medico VALUES (5, 'Luma', 1, 'RJ335544');

CREATE TABLE convenio(
  id_convenio int,
  descricao varchar(100) NOT NULL,
  PRIMARY KEY(id_convenio)
);

INSERT INTO convenio VALUES (1, 'Unimed Campinas');
INSERT INTO convenio VALUES (2, 'CASSI');
INSERT INTO convenio VALUES (3, 'Golden Cross');
INSERT INTO convenio VALUES (4, 'Bradesco');
INSERT INTO convenio VALUES (5, 'Sulamérica');

CREATE TABLE medico_convenio(
  id_convenio int,
  id_medico int,
  PRIMARY KEY(id_convenio, id_medico),
  FOREIGN KEY(id_convenio) REFERENCES convenio(id_convenio),
  FOREIGN KEY(id_medico) REFERENCES medico(id_medico)
);

INSERT INTO medico_convenio VALUES (1, 1);
INSERT INTO medico_convenio VALUES (1, 2);
INSERT INTO medico_convenio VALUES (1, 3);
INSERT INTO medico_convenio VALUES (2, 1);
INSERT INTO medico_convenio VALUES (2, 2);
INSERT INTO medico_convenio VALUES (3, 4);

CREATE TABLE consulta(  
  id_paciente int,
  id_medico int,
  data_consulta date  
);

INSERT INTO consulta VALUES (1, 2, '2014-01-01');
INSERT INTO consulta VALUES (1, 3, '2015-02-01');
INSERT INTO consulta VALUES (2, 1, '2014-01-21');
INSERT INTO consulta VALUES (3, 1, '2014-10-23');
INSERT INTO consulta VALUES (3, 3, '2014-07-21');
INSERT INTO consulta VALUES (3, 5, '2014-07-22');
INSERT INTO consulta VALUES (6, 5, '2014-06-22');
INSERT INTO consulta VALUES (6, 5, '2013-06-22');
INSERT INTO consulta VALUES (6, 5, '2011-06-22');
INSERT INTO consulta VALUES (6, 1, '2014-06-22');