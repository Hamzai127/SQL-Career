CREATE DATABASE RETAIL_SALES_BUSINESS;
USE RETAIL_SALES_BUSINESS;

CREATE TABLE CUSTOMERS (
customer_id INT NOT NULL,
customer_name VARCHAR(50),
city VARCHAR(50),
gender VARCHAR(50)
);

CREATE TABLE PRODUCTS (
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
category VARCHAR(50),
price INT
);

CREATE TABLE ORDERS (
order_id INT NOT NULL,
customer_id INT PRIMARY KEY,
order_date DATE,
total_amount INT NOT NULL
);

CREATE TABLE ORDER_ITEMS (
order_item_id INT NOT NULL,
order_id INT NOT NULL,
product_id INT,
quantity INT
);

INSERT INTO CUSTOMERS (customer_id, customer_name, city, gender)
VALUES
(1, 'Ali Khan', 'Karachi', 'Male'),
(2, 'Sara Ahmed', 'Lahore', 'Female')
;

INSERT INTO PRODUCTS (product_id, product_name, category, price)
VALUES
(1, 'iPhone 13', 'Electronics', 1200),
(2, 'T-Shirt', 'Clothing', 20)
;

INSERT INTO ORDERS (order_id, customer_id, order_date, total_amount)
VALUES
(101, 1, '2023-11-01', 1220),
(102, 2, '2023-11-03', 20)
;

INSERT INTO ORDER_ITEMS (order_item_id, order_id, product_id, quantity)
VALUES
(1, 101, 1, 1),
(2, 101, 2,	1),
(3, 102, 2, 1)
;

SELECT * 
FROM products;

-- LIST ALL CUSTOMERS FROM KARACHI

SELECT *
FROM customers
WHERE city = 'Karachi';

-- Find all orders made in November 2023

SELECT *
FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Get total sales per customer

SELECT c.customer_id, c.customer_name, SUM(o.total_amount) AS Total_spent
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- List products that start with 'T'

SELECT *
FROM PRODUCTS
WHERE product_name LIKE 'T%';

-- List customers who bought Electronics OR Clothing

SELECT DISTINCT c.customer_id, c.customer_name
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN PRODUCTS p ON oi.product_id = p.product_id
WHERE category = 'Electronics' OR category = 'Clothing';

-- Customers who haven’t ordered anything

SELECT c.customer_id, c.customer_name
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Get top 3 selling products by quantity

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM PRODUCTS p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Find average order value by city

SELECT c.city, AVG(o.total_amount) AS Avg_Order_Value
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- Find cities with total sales > 1000

SELECT c.city, SUM(o.total_amount) AS Total_Sales
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING Total_Sales > 1000;

-- Male and Female customer lists separately

SELECT customer_id, customer_name, 'Male' as Gender_type
FROM CUSTOMERS
WHERE gender = 'Male'

UNION

SELECT customer_id, customer_name, 'Female' as Gender_type
FROM CUSTOMERS
WHERE gender = 'Female';

-- Self Join to find customers in the same city

SELECT a.customer_name AS C1, b.customer_name AS C2, a.city
FROM CUSTOMERS a
JOIN CUSTOMERS b ON a.city = b.city AND a.customer_id <> b.customer_id;


