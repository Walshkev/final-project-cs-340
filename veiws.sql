


--C1
CREATE VIEW DiscountCounts AS
SELECT
    current_date AS date,
    COUNT(DISTINCT CASE WHEN ci.is_discounted = TRUE THEN ci.item_id END) AS total_discounted_items,
    COUNT(DISTINCT CASE WHEN ci.is_discounted = TRUE AND ci.item_id NOT IN (
        SELECT item_id FROM CompanyItem WHERE is_discounted = TRUE AND company_id IN (
            SELECT company_id FROM CompanyTransaction WHERE transaction_date = current_date - INTERVAL '1 day'
        )
    ) THEN ci.item_id END) AS new_discounted_items
FROM
    CompanyItem ci
    INNER JOIN Discount d ON ci.discount_id = d.discount_id
GROUP BY
    current_date;

-- C2
CREATE VIEW SortedProductList AS
SELECT * FROM Item 
WHERE item_type = 'product' 
ORDER BY item_name;




