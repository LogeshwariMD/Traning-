use shopping;

SELECT 
    customer_id,
    SUM(quantity * price) AS total_spent
FROM shopping_data
GROUP BY customer_id;


WITH customer_spend AS (
    SELECT 
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM shopping_data
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_position
FROM customer_spend
LIMIT 5;
