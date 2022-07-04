CREATE TABLE students
(
    record_book numeric(5) NOT NULL,
    name text NOT NULL,
    doc_ser numeric(4),
    doc_num numeric(6),
    PRIMARY KEY (record_book)
);

CREATE TABLE progress
(
    record_book numeric(5) NOT NULL,
    subject text NOT NULL,
    acad_year text NOT NULL, 
    term numeric(1) NOT NULL CHECK (term = 1 OR term = 2),
    mark numeric(1) NOT NULL CHECK (mark >= 3 AND mark <= 5) DEFAULT 6,
    FOREIGN KEY (record_book)
    REFERENCES students (record_book)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

-------
--5.3--
-------

ALTER TABLE airports
    ADD COLUMN speed integer NOT NULL CHECK(speed >= 300);

CREATE TABLE fare_conditions
(
    fare_conditions_code integer,
    fare_conditions_name varchar(10) NOT NULL,
    PRIMARY KEY (fare_conditions_code)
);

INSERT INTO fare_conditions
    VALUES 
    (1, 'Economy'),
    (2, 'Business'),
    (3, 'Comfort')

--Замена столбца с изменением типа
ALTER TABLE seats
    DROP CONSTRAINT seats_fare_conditions_check,
    ALTER COLUMN fare_conditions SET DATA TYPE integer
        USING (CASE WHEN fare_conditions = 'Ecomomy' THEN 1
                    WHEN fare_conditions = 'Business' THEN 2
                    ELSE 3 END
        );

--Добавление связи
ALTER TABLE seats
 ADD FOREIGN KEY (fare_conditions)
    REFERENCES fare_conditions (fare_conditions_code);

--Переименование столбца
ALTER TABLE seats
 RENAME COLUMN fare_conditions TO fare_conditions_code;
--Переименование ограничения
ALTER TABLE seats
 RENAME CONSTRAINT seats_fare_conditions_fkey TO seats_fare_conditions_code_fkey;
--Добавление ограничения уникальности для таблицы
ALTER TABLE fare_conditions ADD UNIQUE (fare_conditions_name);

-------
--5.4--
-------

CREATE OR REPLACE VIEW seats_by_fare_cond (code, fare_cond, num_seats)
AS 
    SELECT  aircraft_code,
            fare_conditions_code,
            count(*)
    FROM    seats
    GROUP BY aircraft_code, fare_conditions_code
    ORDER BY aircraft_code, fare_conditions_code;

--Задания по главе
--1

ALTER TABLE students 
    ADD COLUMN IF NOT EXISTS when_adds_row timestamp DEFAULT current_timestamp;

CREATE TABLE students
(
    record_book numeric(5) NOT NULL,
    name text NOT NULL,
    doc_ser numeric(4),
    doc_num numeric(6),
    who_adds_row text DEFAULT current_user,
    when_adds_row timestamp DEFAULT current_timestamp,
    PRIMARY KEY (record_book)
);

--2
ALTER TABLE progress 
    ADD COLUMN IF NOT EXISTS test_form integer;

ALTER TABLE progress 
    ADD CHECK (
        (test_form = 'экзамен' AND mark IN (3,4,5))
        OR 
        (test_form = 'зачет' AND mark IN (0,1))
    );