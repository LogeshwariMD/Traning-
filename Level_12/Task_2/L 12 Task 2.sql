use employees;

CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_address VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name, customer_address)
SELECT DISTINCT 
    customer_id, 
    customer_name, 
    customer_address
FROM Denormalized_Orders;


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


INSERT INTO Orders (order_id, order_date, customer_id)
SELECT DISTINCT 
    order_id, 
    order_date, 
    customer_id
FROM Orders_1NF;

ALTER TABLE Orders_1NF
DROP COLUMN customer_id;

UPDATE Orders_1NF AS o1
JOIN Orders AS o ON o1.product_id = o.product_id
SET o1.order_id = o.order_id;

SELECT * FROM Orders;
SELECT * FROM Customers;
