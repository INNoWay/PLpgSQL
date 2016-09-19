--3
ALTER TABLE paciente 
ADD CHECK (data_nascimento >= '1900-01-01');

--4
ALTER TABLE paciente ADD COLUMN id_convenio int;

ALTER TABLE paciente
ADD FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio);

--Se obrigatoriamente
--todo paciente deve ter um convênio,
--então o id_convenio, em paciente,
--deve ser NOT NULL.
--O SQL abaixo não funcion!
--Porque exitem valores nulos na coluna.
--Entretanto, se estivéssimos na elaboração inicial
--então deveria ser NOT NULL. 
ALTER TABLE paciente ALTER COLUMN id_convenio SET NOT NULL;

--5
--a
SELECT *
FROM paciente
WHERE data_nascimento >= '1980-01-01'
  AND data_nascimento <= '1989-12-31';

SELECT *
FROM paciente
WHERE data_nascimento > '1979-12-31'
  AND data_nascimento < '1990-01-01'; 

SELECT *
FROM paciente
WHERE data_nascimento BETWEEN '1980-01-01' AND '1989-12-31';

--b
SELECT nome
     , descricao
FROM medico          m
   , convenio        c
   , medico_convenio mc
WHERE m.id_medico   = mc.id_medico
  AND c.id_convenio = mc.id_convenio;

SELECT nome
     , descricao
FROM       medico_convenio mc
INNER JOIN medico          m
        ON (m.id_medico = mc.id_medico)
INNER JOIN convenio        c
        ON (c.id_convenio = mc.id_convenio);

--c
SELECT nome
     , descricao
FROM       medico_convenio mc
RIGHT JOIN medico          c
        ON (m.id_medico = mc.id_medico)
LEFT JOIN convenio        c
        ON (c.id_convenio = mc.id_convenio);

SELECT m.*
     , mc.*
FROM      medico         m
LEFT JOIN medico_convenio mc
        ON (m.id_medico = mc.id_medico)
LEFT JOIN convenio        c
        ON (c.id_convenio = mc.id_convenio);

--d
--Exemplo
SELECT id_medico
FROM medico
EXCEPT
SELECT id_medico
FROM medico_convenio;

SELECT nome
FROM medico
WHERE id_medico NOT IN ( SELECT id_medico
                         FROM medico_convenio
                       );

SELECT *
FROM medico
EXCEPT
SELECT m.*
FROM medico_convenio mc
   , medico          m
WHERE mc.id_medico = m.id_medico;

--exemplos
DELETE FROM tabelax
WHERE coluna1 IN (SELECT ...)

UPDATE tabela
SET coluna1 = x
WHERE colunaZ = (SELECT MIN(data_nascimento) FROM paciente)