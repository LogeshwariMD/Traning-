use shopping;

CREATE TABLE customers (
  customer_id VARCHAR(255) PRIMARY KEY,
  gender VARCHAR(50),
  age INT
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(255),
  price DECIMAL(10,2)
);

CREATE TABLE payment_methods (
  method_id INT AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(50)
);

CREATE TABLE malls (
  mall_id INT AUTO_INCREMENT PRIMARY KEY,
  mall_name VARCHAR(255)
);

CREATE TABLE orders (
  invoice_no VARCHAR(255) PRIMARY KEY,
  customer_id VARCHAR(255),
  product_id INT,
  quantity INT,
  method_id INT,
  invoice_date DATE,
  mall_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (method_id) REFERENCES payment_methods(method_id),
  FOREIGN KEY (mall_id) REFERENCES malls(mall_id)
);

select * from orders;

INSERT INTO customers (customer_id, gender, age)
SELECT DISTINCT customer_id, gender, age
FROM shopping_data
WHERE customer_id IS NOT NULL;

INSERT INTO products (category, price)
SELECT DISTINCT category, price
FROM shopping_data
WHERE category IS NOT NULL AND price IS NOT NULL;

INSERT INTO payment_methods (method_name)
SELECT DISTINCT payment_method
FROM shopping_data
WHERE payment_method IS NOT NULL;
INSERT INTO malls (mall_name)
SELECT DISTINCT shopping_mall
FROM shopping_data
WHERE shopping_mall IS NOT NULL;

INSERT INTO orders (invoice_no, customer_id, product_id, quantity, method_id, invoice_date, mall_id)
SELECT
  sd.invoice_no,
  sd.customer_id,
  p.product_id,
  sd.quantity,
  pm.method_id,
  STR_TO_DATE(sd.invoice_date, '%Y-%m-%D'),  -- Make sure date is in correct format
  m.mall_id
FROM shopping_data sd
JOIN products p ON sd.category = p.category AND sd.price = p.price
JOIN payment_methods pm ON sd.payment_method = pm.method_name
JOIN malls m ON sd.shopping_mall = m.mall_name
WHERE sd.customer_id IS NOT NULL;

select * from orders;







