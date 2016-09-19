--e
SELECT descricao
     , COUNT(*)
FROM medico_convenio mc
   , convenio
WHERE mc.id_convenio = convenio.id_convenio
GROUP BY descricao;

--f
SELECT *
FROM consulta
order by id_medico;

SELECT *
FROM medico;

--com except
--diferença de conjuntos
SELECT id_medico
FROM medico
EXCEPT
SELECT id_medico
FROM consulta;

SELECT *
FROM medico
WHERE id_medico NOT IN ( SELECT id_medico
                         FROM consulta
                       );
--Mais trabalhoso
SELECT id_medico, nome
FROM medico
EXCEPT
SELECT c.id_medico, nome
FROM consulta c
   , medico   m
WHERE c.id_medico = m.id_medico;

--g
DELETE FROM consulta
WHERE id_medico IN ( SELECT mc.id_medico
		     FROM medico_convenio mc
			, convenio        c
		     WHERE mc.id_convenio = c.id_convenio
		       AND c.descricao = 'CASSI';
                   );

DELETE FROM consulta
WHERE id_medico IN ( SELECT m.id_medico
		     FROM medico          m
			, consulta        c
			, medico_convenio mc
			, convenio        k
		     WHERE c.id_medico   = m.id_medico
		       AND m.id_medico   = mc.id_medico
		       AND k.id_convenio = mc.id_convenio
		       AND k.descricao LIKE 'CASSI%'
		    );

--h
UPDATE paciente 
SET id_convenio = 2
WHERE data_nascimento BETWEEN '1980-01-01' AND '1989-12-31';

UPDATE paciente 
SET id_convenio = 1
WHERE data_nascimento BETWEEN '1990-01-01' AND '1999-12-31';

UPDATE paciente 
SET id_convenio = 4
WHERE data_nascimento > '1990-12-31';