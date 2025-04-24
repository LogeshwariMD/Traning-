

show tables;

ALTER TABLE Products
ADD COLUMN warehouse_id VARCHAR(10);

select * from Products;

UPDATE Products
SET warehouse_id = CASE
    WHEN product_id = 'P1' THEN 'W1'
    WHEN product_id = 'P2' THEN 'W2'
    WHEN product_id = 'P3' THEN 'W1'
END;


CREATE TABLE Product_Warehouses (
    product_id VARCHAR(10),
    warehouse_id VARCHAR(10),
    PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

select * from Product_warehouses;
INSERT INTO Product_Warehouses (product_id, warehouse_id)
SELECT DISTINCT product_id, warehouse_id
FROM Products;


ALTER TABLE Products DROP COLUMN warehouse_id;


SELECT * FROM Product_Warehouses;
SELECT * FROM Products;
