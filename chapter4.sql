-- Массивы

CREATE TABLE pilots 
(
    pilot_name text,
    schedule integer[]
);

INSERT INTO pilots
    VALUES 
        ('Ivan', '{1,3,5,6,7}'::integer[]),
        ('Petr', '{1,2,5,7}'::integer[]),
        ('Pavel', '{2,5}'::integer[]),
        ('Boris', '{3,5,6}'::integer[]);

UPDATE pilots 
SET schedule = array_append( schedule, 6)
WHERE pilot_name = 'Pavel';

UPDATE pilots 
SET schedule = array_prepend( 1, schedule)
WHERE pilot_name = 'Pavel';

-- JSON

CREATE TABLE pilot_hobbies
(
    pilot_name text,
    hobbies jsonb
);

INSERT INTO pilot_hobbies
    VALUES ('Ivan',
    '{"sports":["футбол", "плавание"],
    "home_lib": true, "trips":3
    }'::jsonb
    ),
    ('Petr',
    '{"sports":["теннис", "плавание"],
    "home_lib": true, "trips":2
    }'::jsonb
    ),
    ('Pavel',
    '{"sports":["плавание"],
    "home_lib": false, "trips":4
    }'::jsonb
    ),
    ('Boris',
    '{"sports":["футбол", "плавание", "теннис"],
    "home_lib": true, "trips":0
    }'::jsonb
    );