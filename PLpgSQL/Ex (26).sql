BEGIN;

SELECT * FROM dep;

UPDATE dep
SET local_dep = 'Y';

SELECT * FROM dep;

SAVEPOINT t1;

UPDATE dep
SET local_dep = 'Z';

SELECT * FROM dep;

ROLLBACK TO SAVEPOINT t1;

COMMIT;


--Schemas
CREATE SCHEMA meuschema;

CREATE TABLE meuschema.dep(
  n_dep int,
  nome_dep varchar(100),
  local_dep varchar(50)
);

SELECT * FROM public.dep;

SELECT * FROM dep;

SELECT * FROM meuschema.dep;

SELECT *
FROM public.dep    a
   , meuschema.dep b
WHERE a.n_dep = b.n_dep;

--GRANT e REVOKE
GRANT SELECT ON meuschema.dep TO teste2;
GRANT USAGE ON SCHEMA meuschema TO teste2;
GRANT CREATE ON SCHEMA meuschema TO teste2;

REVOKE SELECT ON meuschema.dep FROM teste2;

GRANT SELECT ON dep TO public;