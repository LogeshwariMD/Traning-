
CREATE DATABASE IF NOT EXISTS customer_scd;
USE customer_scd;


INSERT INTO customer_dimension (
    customer_id, first_name, last_name, email, loyalty_tier, start_date, end_date, is_current_flag
) VALUES (
    'CUST001', 'Jane', 'Smith', 'jane.smith@email.com', 'Bronze', '2022-01-15', '2023-06-30', 0
);


SELECT * FROM customer_dimension;


UPDATE customer_dimension
SET end_date = '2023-06-30', is_current_flag = 0
WHERE customer_id = 'CUST001' AND is_current_flag = 1;


INSERT INTO customer_dimension (
    customer_id, first_name, last_name, email, loyalty_tier, start_date, end_date, is_current_flag
) VALUES (
    'CUST001', 'Jane', 'Smith', 'jane.smith@email.com', 'Gold', '2023-07-01', '9999-12-31', 1
);


SELECT * FROM customer_dimension;



SELECT * FROM customer_dimension
WHERE customer_id = 'CUST001'
ORDER BY start_date;








