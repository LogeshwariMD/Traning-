use shopping;

SELECT 
    gender,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * price), 2) AS total_spent,
    ROUND(AVG(quantity * price), 2) AS avg_spent_per_order,
    ROUND(MAX(quantity * price), 2) AS max_spent_in_single_order,
    ROUND(MIN(quantity * price), 2) AS min_spent_in_single_order
FROM shopping_data
GROUP BY gender;
