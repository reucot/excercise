WITH sell_ticket AS
( INSERT INTO ticket_flights_tmp
( ticket_no, flight_id, fare_conditions, amount )
VALUES ( '1234567890123', 30829, 'Economy', 12800 )
RETURNING *
)
UPDATE tickets_directions td
SET last_ticket_time = current_timestamp,
tickets_num = tickets_num + 1
WHERE ( td.departure_city, td.arrival_city ) =
( SELECT departure_city, arrival_city
FROM flights_v
WHERE flight_id = ( SELECT flight_id FROM sell_ticket )
);

--Задания по главе
--2
WITH add_row AS
( INSERT INTO aircrafts_tmp
SELECT * FROM aircrafts
RETURNING aircraft_code, model, range,
current_timestamp, 'INSERT'
)
INSERT INTO aircrafts_log
SELECT * FROM add_row;




