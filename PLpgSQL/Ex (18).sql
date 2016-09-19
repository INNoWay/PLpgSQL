--1
ALTER TABLE medico ADD UNIQUE (crm);
ALTER TABLE medico ALTER COLUMN crm SET NOT NULL;

--2
ALTER TABLE consulta 
ADD PRIMARY KEY (id_paciente, id_medico, data_consulta);

--Não esquecer da chave estrangeira
ALTER TABLE consulta
ADD FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente);

ALTER TABLE consulta
ADD FOREIGN KEY (id_medico) REFERENCES medico(id_medico);

--Outra solução
--mais trabalhosas
ALTER TABLE consulta
ADD id_consulta int;

--preencher os dados da coluna id_coluna
--com valores únicos
ALTER TABLE consulta
ADD PRIMARY KEY (id_consulta);

ALTER TABLE consulta
ADD UNIQUE (id_paciente, id_medico, data_consulta);

--Colocar NOT NULL em cada uma das colunas

--3
