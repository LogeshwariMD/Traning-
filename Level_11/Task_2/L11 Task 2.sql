USE employees;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Sales');

INSERT INTO employees (id, name, department, salary) VALUES
(4, 'Diana', 'HR', 60000),
(5, 'Evan', NULL, 55000);


SELECT e.id, e.name, e.department, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON e.department = d.department_name;


SELECT e.id, e.name, e.department, e.salary, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department = d.department_name;


SELECT e.id, e.name, e.department, e.salary, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department = d.department_name;


SELECT e.id, e.name, e.department, e.salary, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department = d.department_name
UNION
SELECT e.id, e.name, e.department, e.salary, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department = d.department_name;
