-- users


CREATE TABLE tempusers (
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255),
    email VARCHAR(255),
    street_address VARCHAR(255),
    city_address VARCHAR(255),
    state_address VARCHAR(255)
);

\copy tempusers(first_name, last_name, username, email, street_address, city_address, state_address) FROM 'C:\Users\kcw13\OneDrive\Documents\CSwinter2024\data base\final project\files\users.csv' WITH DELIMITER ',' CSV HEADER;

DELETE FROM tempusers
WHERE email NOT LIKE '%@%' OR (email NOT LIKE '%.com' AND email NOT LIKE '%.edu');

DELETE FROM tempusers
WHERE NOT (first_name ~ '^[A-Z]' AND last_name ~ '^[A-Z]');

DELETE FROM tempusers
WHERE NOT (state_address ~ '^[A-Z]');

WITH duplicates_cte AS (
    SELECT email,
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY (SELECT NULL)) AS row_num
    FROM tempusers
)
DELETE FROM tempusers
WHERE email IN (SELECT email FROM duplicates_cte WHERE row_num > 1);

INSERT INTO Users (user_email, first_name, last_name, street_address, city, state)
SELECT email, first_name, last_name, street_address, city_address, state_address
FROM tempusers;

