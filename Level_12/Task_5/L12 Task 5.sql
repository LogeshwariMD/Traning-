use employees;


CREATE TABLE Customer_Addresses (
    customer_id VARCHAR(10),
    address VARCHAR(100),
    PRIMARY KEY (customer_id, address),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Customer_Phones (
    customer_id VARCHAR(10),
    phone_number VARCHAR(15),
    PRIMARY KEY (customer_id, phone_number),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


INSERT INTO Customer_Addresses (customer_id, address)
VALUES 
    ('C1', '123 Main St'),
    ('C1', '456 Park Ave');


INSERT INTO Customer_Phones (customer_id, phone_number)
VALUES 
    ('C1', '555-1234'),
    ('C1', '555-5678');


ALTER TABLE Customers DROP COLUMN customer_address;
ALTER TABLE Customers DROP COLUMN phone_number;


SELECT * FROM Customer_Addresses;
SELECT * FROM Customer_Phones;
SELECT * FROM Customers;
