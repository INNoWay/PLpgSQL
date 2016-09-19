--1a
ALTER TABLE cliente ADD UNIQUE (rg, uf_rg);

--é um plus
ALTER TABLE cliente ALTER COLUMN rg SET NOT NULL;
ALTER TABLE cliente ALTER COLUMN uf_rg SET NOT NULL;

--1b
ALTER TABLE conta ALTER COLUMN saldo SET NOT NULL;

--Outra opção
ALTER TABLE conta ADD CHECK (saldo IS NOT NULL);

--1c
ALTER TABLE conta_cliente 
  ADD FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);
  
ALTER TABLE conta_cliente 
  ADD FOREIGN KEY (id_conta) REFERENCES conta(id_conta);
  
--1d
ALTER TABLE conta_cliente ADD PRIMARY KEY (id_cliente, id_conta);

--2a
SELECT *
FROM cliente
WHERE uf_rg IN ('SP', 'MG');

SELECT *
FROM cliente
WHERE uf_rg = 'SP'
   OR uf_rg = 'MG';
  
--2b
SELECT cliente.nome
     , conta.saldo
FROM cliente       cli
   , conta         co
   , conta_cliente cc
WHERE cc.id_cliente = cli.id_cliente
  AND cc.id_conta   = co.id_conta;
  
SELECT cliente.nome
     , conta.saldo
FROM       cliente       cli
INNER JOIN conta         co
        ON (cc.id_cliente = cli.id_cliente)
INNER JOIN conta_cliente cc
        ON (cc.id_conta   = co.id_conta);
        
--2c

--INNER JOIN / Não é a resposta! Precisamos de um OUTER JOIN
SELECT conta.*
     , agencia.*
FROM conta
   , agencia
WHERE conta.id_agencia = agencia.id_agencia;

SELECT *
FROM       conta
RIGHT JOIN agencia
        ON (conta.id_agencia = agencia.id_agencia);
        
SELECT *
FROM      agencia
LEFT JOIN conta
        ON (conta.id_agencia = agencia.id_agencia);        
        
--2d
SELECT id_agencia
     , COUNT(*)
FROM conta
GROUP BY id_agencia;

--2e
UPDATE conta
SET saldo = saldo * 1.1
WHERE id_agencia IN ( SELECT id_agencia 
                      FROM agencia
                      WHERE uf = 'SP'
                    );
                    
UPDATE conta
SET saldo = saldo * 1.1
WHERE EXISTS ( SELECT id_agencia 
                FROM agencia
                WHERE uf = 'SP'
                  AND conta.id_agencia = agencia.id_agencia
             );
             
--2f
SELECT SUM(saldo)
FROM conta
WHERE id_agencia IN ( SELECT id_agencia 
                      FROM agencia
                      WHERE uf = 'SP'
                    );

SELECT SUM(saldo)
FROM conta
   , agencia
WHERE conta.id_agencia = agencia.id_agencia
  AND agencia.uf       = 'SP';