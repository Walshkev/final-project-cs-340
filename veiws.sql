


--C1


CREATE VIEW DiscountCounts AS
SELECT
    current_date AS date,
    COUNT(*) AS total_discounted_items,
    COUNT(CASE WHEN item_id NOT IN (
        SELECT item_id FROM CompanyItem WHERE is_discounted = TRUE AND company_id IN (
            SELECT company_id FROM CompanyTransaction WHERE transaction_date = current_date - INTERVAL '1 day'
        )
    ) THEN 1 END) AS new_discounted_items
FROM
    CompanyItem
WHERE
    is_discounted = TRUE
GROUP BY
    current_date;

    

-- C2
CREATE VIEW SortedProductList AS
SELECT * FROM Item 
ORDER BY item_name;


