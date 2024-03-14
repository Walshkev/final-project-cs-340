
-- service

CREATE TABLE tempserv (
    service_id VARCHAR(20),
    service_name VARCHAR(750),
    brand_company_name VARCHAR(255),
    service_category VARCHAR(50)
);

\copy tempserv(service_id, service_name, brand_company_name, service_category) FROM 'C:\Users\kcw13\OneDrive\Documents\CSwinter2024\data base\final project\files\services.csv' WITH DELIMITER ',' CSV HEADER;

WITH duplicates_cte AS (
    SELECT service_id,
           ROW_NUMBER() OVER (PARTITION BY service_id ORDER BY (SELECT NULL)) AS row_num
    FROM tempserv
)
DELETE FROM tempserv
WHERE service_id IN (SELECT service_id FROM duplicates_cte WHERE row_num > 1);

DELETE FROM tempserv
WHERE service_id IS NULL OR service_id = ''
   OR service_name IS NULL OR service_name = '';

INSERT INTO Company (company_name)
SELECT DISTINCT brand_company_name
FROM tempserv
WHERE brand_company_name IS NOT NULL;

WITH duplicates_cte AS (
    SELECT company_name,
           ROW_NUMBER() OVER (PARTITION BY company_name ORDER BY company_id) AS row_num
    FROM Company
)
DELETE FROM Company
WHERE company_name IN (SELECT company_name FROM duplicates_cte WHERE row_num > 1);

INSERT INTO Item (item_id, item_type, item_name)
SELECT service_id, 'service', service_name
FROM tempserv;
