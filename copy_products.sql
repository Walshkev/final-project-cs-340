
CREATE TABLE tempproducts (
    product_id VARCHAR(20),
    product_name VARCHAR(750),
    brand_company_name VARCHAR(255),
    product_category VARCHAR(50)
);

\copy tempproducts(product_id, product_name, brand_company_name, product_category) FROM 'C:\Users\kcw13\OneDrive\Documents\CSwinter2024\data base\final project\files\products.csv' WITH DELIMITER '|' CSV HEADER;

DELETE FROM tempproducts
WHERE product_id IS NULL OR product_id = '' OR
      product_name IS NULL OR product_name = '';

WITH duplicates_cte AS (
    SELECT product_id,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY (SELECT NULL)) AS row_num
    FROM tempproducts
)
DELETE FROM tempproducts
WHERE product_id IN (SELECT product_id FROM duplicates_cte WHERE row_num > 1);

INSERT INTO Company (company_name)
SELECT DISTINCT brand_company_name
FROM tempproducts
WHERE brand_company_name IS NOT NULL;

INSERT INTO Item (item_id, item_type, item_name)
SELECT product_id, 'product', product_name
FROM tempproducts;