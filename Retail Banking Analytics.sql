CREATE DATABASE RETAIL_BANKING_ANALYTICS;
USE RETAIL_BANKING_ANALYTICS;

CREATE TABLE customers (
    customer_id INT,
    full_name VARCHAR(100),
    gender CHAR(1),
    dob DATE,
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE accounts (
	account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(30),
    balance INT,
    status_ VARCHAR(10)
);

-- List all active customers from Lahore

SELECT c.customer_id, c.full_name, c.city, a.status_
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE c.city = 'Lahore' AND a.status_ = 'Active';

-- Find total balance per customer

SELECT c.customer_id, c.full_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.full_name;

-- Show customers who have taken loans

SELECT c.customer_id, c.full_name
FROM customers c 
JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.full_name;

-- List all Debit transactions in January 2024

SELECT t.txn_id, t.account_id, t.txn_date, t.amount
FROM transactions t
WHERE t.txn_type = 'Debit' AND t.txn_date BETWEEN '2024-01-01' AND '2024-01-31';

-- Find customers with both loan and savings account

SELECT DISTINCT c.customer_id, c.full_name
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN loans l ON c.customer_id = l.customer_id
WHERE a.account_type = 'Saving';

-- Top 3 customers by transaction volume

SELECT c.full_name, SUM(t.amount) AS transaction_volume
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.full_name
ORDER BY transaction_volume DESC
LIMIT 3;

-- Show all accounts with no transactions

SELECT a.account_type, t.txn_type, t.amount, a.status_
FROM accounts a 
LEFT JOIN transactions t ON a.account_id = t.account_id 
WHERE t.amount IS NULL AND a.status_ = 'Active';

-- Show customers older than 35 years

SELECT customer_id, full_name, dob
FROM customers
WHERE YEAR(curdate())-YEAR(dob) > 35;

-- List customers with more than 2 accounts

SELECT customer_id, COUNT(account_id) AS No_of_accounts
FROM accounts  
GROUP BY customer_id 
HAVING COUNT(account_id) > 2;

-- Find loan amount by loan type

SELECT DISTINCT loan_type, SUM(amount) AS Total_Loan_amount
FROM loans
GROUP BY loan_type;

-- Customers from same city (for referrals)

SELECT a.full_name AS c1, b.full_name AS c2, a.city
FROM customers a 
JOIN customers b ON a.city=b.city AND a.customer_id <> b.customer_id;

-- All debit and credit transactions separately labeled

SELECT txn_id, account_id, txn_date, amount, 'Debit' AS type
FROM transactions
WHERE txn_type = 'Debit'
UNION ALL
SELECT txn_id, account_id, txn_date, amount, 'Credit' AS type
FROM transactions
WHERE txn_type = 'Credit';









