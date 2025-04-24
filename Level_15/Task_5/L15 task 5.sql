use shopping;

WITH customer_orders AS (
    SELECT 
        customer_id,
        invoice_date,
        QUARTER(invoice_date) AS quarter,
        YEAR(invoice_date) AS year
    FROM shopping_data
),
latest_quarter AS (
    SELECT 
        MAX(YEAR(invoice_date)) AS max_year,
        MAX(QUARTER(invoice_date)) AS max_quarter
    FROM shopping_data
),
current_prev_orders AS (
    SELECT 
        co.customer_id,
        co.year,
        co.quarter,
        CONCAT(co.year, '-', co.quarter) AS year_quarter
    FROM customer_orders co
    JOIN latest_quarter lq
    ON 
        (co.year = lq.max_year AND co.quarter = lq.max_quarter)
        OR 
        (co.year = lq.max_year AND co.quarter = lq.max_quarter - 1)
),
grouped_orders AS (
    SELECT 
        customer_id,
        SUM(CASE WHEN quarter = (SELECT max_quarter FROM latest_quarter) THEN 1 ELSE 0 END) AS current_qtr_orders,
        SUM(CASE WHEN quarter = (SELECT max_quarter FROM latest_quarter) - 1 THEN 1 ELSE 0 END) AS previous_qtr_orders
    FROM current_prev_orders
    GROUP BY customer_id
)

SELECT COUNT(*) AS repeat_customers
FROM grouped_orders
WHERE current_qtr_orders > 0 AND previous_qtr_orders > 0;
