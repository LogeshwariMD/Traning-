show databases;
create database employee;

use employee;
CREATE TABLE sales (
    sale_id INT,
    sale_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO sales (sale_id, sale_date, amount) VALUES
(1, '2023-10-01', 100),
(2, '2023-10-02', 200),
(3, '2023-10-03', 150),
(4, '2023-10-04', 300);


WITH october_sales AS (
    SELECT * 
    FROM sales
    WHERE sale_date BETWEEN '2023-10-01' AND '2023-10-31'
)

SELECT 
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM october_sales;
