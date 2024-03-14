


--C1
CREATE VIEW DiscountCounts AS
SELECT
    current_date AS date,
    COUNT(DISTINCT CASE WHEN companyItem.is_discounted = TRUE THEN companyItem.item_id END) AS total_discounted_items,
    COUNT(DISTINCT CASE WHEN companyItem.is_discounted = TRUE AND companyItem.item_id NOT IN (
        SELECT item_id FROM CompanyItem WHERE is_discounted = TRUE AND company_id IN (
            SELECT company_id FROM CompanyTransaction WHERE transaction_date = current_date - INTERVAL '1 day'
        )
    ) THEN companyItem.item_id END) AS new_discounted_items
FROM
    CompanyItem companyItem
    INNER JOIN Discount d ON companyItem.discount_id = d.discount_id
GROUP BY
    current_date;


-- CREATE VIEW DiscountCount AS
-- SELECT
--     current_date AS date,
--     COUNT(*) AS total_discounted_items,
--     COUNT(CASE WHEN discount_id IS NULL THEN 1 END) AS new_discounted_items
-- FROM
--     Discount
-- WHERE
--     discount_percentage > 0
-- GROUP BY
--     current_date;

-- C2
CREATE VIEW SortedProductList AS
SELECT * FROM Item 
WHERE item_type = 'product' 
ORDER BY item_name;




