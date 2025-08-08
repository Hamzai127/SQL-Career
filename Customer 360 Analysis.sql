CREATE DATABASE CUSTOMER_360_ANALYSIS;
USE CUSTOMER_360_ANALYSIS;

-- Show top 5 customers with highest account balance

SELECT c.full_name, a.account_type, a.balance
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
ORDER BY balance DESC
LIMIT 3;

-- Count customers by city (filter for more than 1)

SELECT city, count(*) AS cust_cnt
FROM customers
GROUP BY city
HAVING cust_cnt > 1;

-- Format full name to uppercase using string functions

SELECT customer_id, upper(full_name) AS Cust_full_name
FROM customers;

-- Show customers' full names in UPPERCASE, and city in lowercase

SELECT customer_id,
UPPER(full_name) AS FULL_NAME,
LOWER(city) AS CITY
FROM customers;

--  Identify customers with long names (name length < 15)

SELECT
customer_id,
full_name,
length(full_name) AS legth_full_name
FROM customers
WHERE length(full_name) < 15;

-- Categorize customers based on their balance

SELECT 
c.customer_id,
c.full_name,
a.balance,
	CASE
		WHEN a.balance <= 15000 THEN 'LOW'
        WHEN a.balance BETWEEN 15000 AND 40000 THEN 'MEDIUM'
        ELSE 'HIGH'
	END AS Bal_Category
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

-- Customers whose name starts with "Cust"

SELECT customer_id, full_name
FROM customers
WHERE full_name LIKE 'Cust%';

-- Accounts opened in 2021 or 2022

SELECT account_id, account_type, open_date
FROM accounts 
WHERE open_date BETWEEN '2021-01-01' AND '2022-12-31';

-- Customers with account balance above average

SELECT c.full_name, a.balance
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
WHERE a.balance > (
	SELECT AVG(balance)
    FROM accounts);
    
-- Add a city-branch report

SELECT 
b.branch_name,
concat(c.city, '-', b.location) AS city_branch
FROM customers c 
JOIN branches b ON c.city = b.location;


