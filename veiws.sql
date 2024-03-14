


--C1

CREATE VIEW Discount_counts_on_date AS
SELECT 
    CURRENT_DATE AS date_today, 
    COUNT(CASE WHEN CURRENT_DATE >= discount_start_date AND CURRENT_DATE < discount_end_date THEN 1 END) AS discounts_today, 
    COUNT(CASE WHEN CURRENT_DATE = discount_start_date THEN 1 END) AS not_discounted_yesterday
FROM 
    Discount;

select * from discount_counts_on_date;

--to test 
INSERT INTO Discount (discount_id, discount_type, discount_amount, discount_description, discount_start_date, discount_end_date) 
VALUES (33, 'other', 10.00, 'Random discount1', '2024-03-14', '2022-12-31');
    
INSERT INTO Discount (discount_id, discount_type, discount_amount, discount_description, discount_start_date, discount_end_date) 
VALUES (50, 'other', 10.00, 'Random discount2', '2024-03-10', '2024-12-31');
    
-- C2
CREATE VIEW SortedProductList AS
SELECT * FROM Item 
ORDER BY item_name;







