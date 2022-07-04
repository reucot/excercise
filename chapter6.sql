--Задания по главе

--2

SELECT 
    passenger_name
FROM
    tickets
WHERE
    passenger_name LIKE '% _____'


 --6

SELECT 
    * 
FROM routes r
RIGHT JOIN (
	SELECT 
		a.aircraft_code,
		a.model
	FROM 
	aircrafts a
	WHERE a.model LIKE 'Боинг %') AS a
ON r.aircraft_code = a.aircraft_code

--7

WITH f1 AS (
SELECT DISTINCT 
    departure_city,
    arrival_city
FROM
    routes r
JOIN
    aircrafts a ON r.aircraft_code = a.aircraft_code
WHERE
    a.model = 'Боинг 777-300'
ORDER BY 1)

SELECT
	f1.departure_city,
	f1.arrival_city,
	f2.departure_city,
	f2.arrival_city
FROM f1, f1 f2
WHERE f1.departure_city = f2.arrival_city AND f2.departure_city = f1.arrival_city  


--9
SELECT 
departure_city,
arrival_city,
count( * )
FROM routes
GROUP BY 
	departure_city,
	arrival_city
HAVING
	departure_city = 'Москва' AND arrival_city = 'Санкт-Петербург'


--11
SELECT departure_city, array_length(days_of_week,1) AS c
FROM routes
WHERE
	departure_city = 'Москва'
ORDER BY
	c DESC


-- 13
SELECT f.departure_city, f.arrival_city,
max( tf.amount ), min( tf.amount )
FROM flights_v f
LEFT JOIN ticket_flights tf ON f.flight_id = tf.flight_id
GROUP BY 1, 2
HAVING
 max( tf.amount ) ISNULL
ORDER BY 1, 2
