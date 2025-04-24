use employees;
SHOW TABLES;
SELECT 
    order_id, 
    order_date, 
    customer_id, 
    product_id, 
    quantity, 
    price 
FROM Denormalized_Orders;

SELECT * FROM Orders_1NF;