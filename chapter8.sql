CREATE INDEX
ON airports ( airport_name );

--Задания по главе

--3
CREATE INDEX fare_conditions
ON ticket_flights (fare_conditions);

--4
CREATE INDEX airport_name_city
ON airports_data (airport_name DESC NULLS FIRST,city ASC NULLS LAST)
