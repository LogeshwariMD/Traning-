
CREATE DATABASE  banking_system;
USE banking_system;



CREATE TABLE Branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(50),
    phone VARCHAR(15)
);


CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('M', 'F'),
    dob DATE,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200)
);


CREATE TABLE Account (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    branch_id INT,
    account_type ENUM('Savings', 'Current', 'Fixed Deposit'),
    balance DECIMAL(15, 2),
    open_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT,
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer'),
    amount DECIMAL(15, 2),
    transaction_date DATE,
    FOREIGN KEY (account_number) REFERENCES Account(account_number)
);


CREATE TABLE Loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    branch_id INT,
    loan_type ENUM('Home Loan', 'Car Loan', 'Personal Loan'),
    loan_amount DECIMAL(15, 2),
    start_date DATE,
    end_date DATE,
    status ENUM('Approved', 'Pending', 'Rejected'),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


INSERT INTO Branch (branch_name, address, city, state, phone) VALUES
('Central Branch', '123 Main St', 'Cityville', 'StateX', '111-111-1111'),
('North Branch', '456 Maple Ave', 'Northside', 'StateY', '222-222-2222');


INSERT INTO Customer (first_name, last_name, gender, dob, phone, email, address) VALUES
('John', 'Doe', 'M', '1990-05-15', '555-555-5555', 'john.doe@example.com', '789 Oak St'),
('Jane', 'Smith', 'F', '1985-07-20', '666-666-6666', 'jane.smith@example.com', '456 Pine St');


INSERT INTO Account (customer_id, branch_id, account_type, balance, open_date) VALUES
(1, 1, 'Savings', 10000.00, '2023-01-01'),
(2, 2, 'Current', 20000.00, '2023-01-10');


INSERT INTO Employee (first_name, last_name, position, salary, branch_id) VALUES
('Michael', 'Johnson', 'Manager', 80000, 1),
('Sara', 'Lee', 'Clerk', 40000, 2);


INSERT INTO Transaction (account_number, transaction_type, amount, transaction_date) VALUES
(1, 'Deposit', 5000.00, '2023-02-01'),
(2, 'Withdrawal', 2000.00, '2023-02-15');


INSERT INTO Loan (customer_id, branch_id, loan_type, loan_amount, start_date, end_date, status) VALUES
(1, 1, 'Home Loan', 500000.00, '2023-03-01', '2033-03-01', 'Approved'),
(2, 2, 'Car Loan', 300000.00, '2023-04-01', '2028-04-01', 'Pending');


SELECT 
    c.first_name AS Customer,
    a.account_type AS AccountType,
    t.transaction_type AS TransactionType,
    t.amount AS TransactionAmount
FROM Transaction t
JOIN Account a ON t.account_number = a.account_number
JOIN Customer c ON a.customer_id = c.customer_id;


SELECT 
    c.first_name AS Customer,
    l.loan_type AS LoanType,
    l.loan_amount AS LoanAmount,
    l.status AS LoanStatus
FROM Loan l
JOIN Customer c ON l.customer_id = c.customer_id;



SELECT c.first_name, a.account_type, a.balance 
FROM Customer c 
JOIN Account a ON c.customer_id = a.customer_id;


SELECT b.branch_name, e.first_name, e.position 
FROM Branch b 
JOIN Employee e ON b.branch_id = e.branch_id;


SELECT a.account_number, t.transaction_type, t.amount 
FROM Account a 
JOIN Transaction t ON a.account_number = t.account_number;



