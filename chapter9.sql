-- Read uncommited
--first terminal
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SHOW transaction_isolation;

UPDATE aircrafts_tmp
SET range = range + 100
WHERE aircraft_code = 'SU9';

SELECT *
FROM aircrafts_tmp
WHERE aircraft_code = 'SU9';

ROLLBACK;

--second terminal
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT *
FROM aircrafts_tmp
WHERE aircraft_code = 'SU9';

ROLLBACK;

--Read uncommited
--first terminal
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;
UPDATE aircrafts_tmp
SET range = range + 100
WHERE aircraft_code = 'SU9';
SELECT *
FROM aircrafts_tmp
WHERE aircraft_code = 'SU9';

--second terminal
BEGIN;
UPDATE aircrafts_tmp
SET range = range + 200
WHERE aircraft_code = 'SU9';

--Repeatable Read
--first terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM aircrafts_tmp;

--second terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
INSERT INTO aircrafts_tmp
VALUES ( 'IL9', 'Ilyushin IL96', 9800 );
UPDATE aircrafts_tmp
SET range = range + 100
WHERE aircraft_code = '320';
END;

--Serializable
CREATE TABLE modes (
num integer,
mode text
);

INSERT INTO modes VALUES ( 1, 'LOW' ), ( 2, 'HIGH' );
--first terminal
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE modes
SET mode = 'HIGH'
WHERE mode = 'LOW'
RETURNING *;

--second terminal
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE modes
SET mode = 'LOW'
WHERE mode = 'HIGH'
RETURNING *;