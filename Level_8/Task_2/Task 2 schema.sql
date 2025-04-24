
CREATE DATABASE IF NOT EXISTS ecommerce_schema;
USE ecommerce_schema;


SHOW DATABASES;


CREATE TABLE Sales_Fact (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    time_id INT,
    store_id INT,
    sales_amount DECIMAL(10, 2),
    quantity INT
);


CREATE TABLE Product_Dim (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Customer_Dim (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    loyalty_tier VARCHAR(50)
);


CREATE TABLE Time_Dim (
    time_id INT PRIMARY KEY,
    date DATE,
    month VARCHAR(20),
    quarter VARCHAR(10),
    year INT
);

-- Dimension Table: Store_Dim
CREATE TABLE Store_Dim (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    location VARCHAR(100)
);


SHOW TABLES;




INSERT INTO Product_Dim VALUES 
(1, 'Laptop', 'Electronics', 80000),
(2, 'Phone', 'Electronics', 30000);


INSERT INTO Customer_Dim VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', 'Gold'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'Silver');


INSERT INTO Time_Dim VALUES 
(1, '2025-01-01', 'January', 'Q1', 2025),
(2, '2025-02-01', 'February', 'Q1', 2025);


INSERT INTO Store_Dim VALUES 
(1, 'Main Store', 'New York'),
(2, 'Branch Store', 'Los Angeles');


INSERT INTO Sales_Fact VALUES 
(1, 1, 1, 1, 1, 80000, 1),
(2, 2, 2, 2, 2, 60000, 2);


SELECT * FROM Sales_Fact;




CREATE TABLE Sales_Fact_Snowflake (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    time_id INT,
    store_id INT,
    sales_amount DECIMAL(10, 2),
    quantity INT
);


CREATE TABLE Product_Dim_Snowflake (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2)
);


CREATE TABLE Product_Category_Dim (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);


CREATE TABLE Customer_Dim_Snowflake (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    location_id INT,
    loyalty_tier VARCHAR(50)
);


CREATE TABLE Customer_Location_Dim (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100)
);


CREATE TABLE Time_Dim_Snowflake (
    time_id INT PRIMARY KEY,
    date DATE,
    month VARCHAR(20),
    quarter VARCHAR(10),
    year INT
);


CREATE TABLE Store_Dim_Snowflake (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    location_id INT
);


CREATE TABLE Store_Location_Dim (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100)
);


SHOW TABLES;





INSERT INTO Product_Category_Dim VALUES 
(1, 'Electronics');


INSERT INTO Product_Dim_Snowflake VALUES 
(1, 'Laptop', 1, 80000),
(2, 'Phone', 1, 30000);


INSERT INTO Customer_Location_Dim VALUES 
(1, 'New York', 'NY'),
(2, 'Los Angeles', 'CA');


INSERT INTO Customer_Dim_Snowflake VALUES 
(1, 'John', 'Doe', 1, 'Gold'),
(2, 'Jane', 'Smith', 2, 'Silver');


INSERT INTO Store_Location_Dim VALUES 
(1, 'New York', 'NY'),
(2, 'Los Angeles', 'CA');


INSERT INTO Store_Dim_Snowflake VALUES 
(1, 'Main Store', 1),
(2, 'Branch Store', 2);


INSERT INTO Time_Dim_Snowflake VALUES 
(1, '2025-01-01', 'January', 'Q1', 2025),
(2, '2025-02-01', 'February', 'Q1', 2025);


INSERT INTO Sales_Fact_Snowflake VALUES 
(1, 1, 1, 1, 1, 80000, 1),
(2, 2, 2, 2, 2, 60000, 2);


SELECT * FROM Sales_Fact_Snowflake;




