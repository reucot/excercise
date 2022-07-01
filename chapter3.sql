-- Создание таблицы самолеты
CREATE TABLE aircrafts 
(
    aircraft_code char(3) NOT NULL,
    model text NOT NULL,
    range integer NOT NULL,
    CHECK (range > 0),
    PRIMARY KEY (aircraft_code)
);

INSERT INTO aircrafts (aircrat_code,model,range)
VALUES
    ('SU9', 'Sukhoi SuperJet-100', '3000');


--Создание таблицы места
CREATE TABLE seats 
(
    aircraft_code char(3) NOT NULL,
    seat_no varchar(4) NOT NULL,
    fare_conditions varchar(10) NOT NULL,
    CHECK(
        fare_conditions IN ('Economy', 'Comfort', 'Business')
    ),
    PRIMARY KEY (aircraft_code, seat_no),
    FOREIGN KEY (aircraft_code)
        REFERENCES aircrafts (aircraft_code) ON DELETE CASCADE
);

INSERT INTO seats
VALUES
    ('SU9', '1A', 'Business'),
    ('SU9', '1B', 'Business'),
    ('SU9', '10A', 'Economy'),
    ('SU9', '10B', 'Economy'),
    ('SU9', '10F', 'Economy'),
    ('SU9', '20F', 'Economy');
