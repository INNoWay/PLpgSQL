--1
ALTER TABLE medico ADD UNIQUE(crm);
ALTER TABLE medico ALTER COLUMN crm SET NOT NULL;

--2
ALTER TABLE consulta ADD FOREIGN KEY (id_medico) REFERENCES medico(id_medico);
ALTER TABLE consulta ADD FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente);
ALTER TABLE consulta ADD PRIMARY KEY(id_medico, id_paciente, data_consulta);

--3
ALTER TABLE paciente ADD CHECK (data_nascimento > '1900-01-01');

--4
ALTER TABLE paciente ADD id_convenio int;
ALTER TABLE paciente ADD FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio);

--5
--a
SELECT *
FROM paciente
WHERE data_nascimento >= '1980-01-01'
  AND data_nascimento <= '1989-12-31';

--b
SELECT medico.nome
     , convenio.descricao
FROM medico
   , convenio
   , medico_convenio
WHERE medico_convenio.id_convenio = convenio.id_convenio
  AND medico_convenio.id_medico   = medico.id_medico;

SELECT medico.nome
     , convenio.descricao
FROM       medico_convenio
INNER JOIN convenio
        ON (medico_convenio.id_convenio = convenio.id_convenio)
INNER JOIN medico
        ON (medico_convenio.id_medico   = medico.id_medico);

--c
SELECT medico.nome
     , convenio.descricao
FROM      medico
LEFT JOIN medico_convenio
       ON (medico_convenio.id_medico   = medico.id_medico)
LEFT JOIN convenio
       ON (medico_convenio.id_convenio = convenio.id_convenio);

--d
SELECT medico.nome
FROM medico
WHERE id_medico NOT IN (SELECT id_medico
                        FROM medico_convenio
                       );

--e
SELECT convenio.descricao
     , COUNT(*)
FROM medico_convenio
   , convenio
WHERE medico_convenio.id_convenio = convenio.id_convenio
GROUP BY convenio.descricao;

--f
SELECT nome
FROM medico
WHERE id_medico NOT IN (SELECT id_medico
                        FROM consulta
                       );

--g
DELETE FROM consulta
WHERE id_medico IN (SELECT medico_convenio.id_medico
                    FROM convenio
                       , medico_convenio
                    WHERE medico_convenio.id_convenio = convenio.id_convenio
                      AND descricao                   = 'CASSI'
                    );
--h
UPDATE paciente
SET id_convenio = 2
WHERE data_nascimento BETWEEN '1980-01-01' AND '1989-12-31';

UPDATE paciente
SET id_convenio = 1
WHERE data_nascimento BETWEEN '1990-01-01' AND '1990-12-31';

UPDATE paciente
SET id_convenio = 4
WHERE data_nascimento >= '2000-01-01';

--i
CREATE FUNCTION contar_medico_convenio(v_id_medico int)
RETURNS varchar AS $$
DECLARE
  v_count int;
BEGIN
  SELECT COUNT(*)
    INTO v_count
  FROM medico_convenio
  WHERE id_medico = v_id_medico;

  IF v_count > 1 THEN
    RETURN 'Médico atende mais de um convênio';
  END IF;

  RETURN 'Não atende mais de um convênio';
END;
$$ LANGUAGE plpgsql;