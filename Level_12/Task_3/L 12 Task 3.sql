use employees;

CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, price)
SELECT DISTINCT 
    product_id, 
    product_name, 
    price
FROM Denormalized_Orders;


CREATE TABLE Order_Details (
    order_id INT,
    product_id VARCHAR(10),
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Order_Details (order_id, product_id, quantity)
SELECT 
    order_id,
    product_id,
    quantity
FROM Orders_1NF;





select * from products;

select * from Order_details;