CREATE DATABASE Customer_Insights;
USE Customer_Insights;

-- All distinct customers across loans and accounts

SELECT customer_id FROM account_customers
UNION
SELECT customer_id FROM loan_customers;

-- Customers who have both loans and accounts

SELECT lc.customer_id, ac.account_id
FROM loan_customers lc
INNER JOIN account_customers ac ON lc.customer_id=ac.customer_id;

-- Customer segmentation based on account balance

SELECT 
customer_id,
balance,
	CASE
		WHEN balance < 25000 THEN 'Bronze'
        WHEN balance Between 25000 AND 50000 THEN 'Silver'
        ELSE 'Gold'
	END AS Balance_Segs
FROM account_customers;

-- Mask customer ID using LEFT and CONCAT

SELECT customer_id,
CONCAT('XX', LEFT(customer_id, 3)) AS Masked_Id
FROM loan_customers;

-- Mask customer ID using LEFT and CONCAT

SELECT ac.customer_id, ac.balance
FROM account_customers ac
WHERE ac.balance > (
	SELECT AVG(loan_amount) AS Avg_loan
		FROM loan_customers);

-- Use RIGHT to get last characters from customer ID

SELECT customer_id,
RIGHT(Customer_id,3) AS Last_3_digits
FROM loan_customers;

-- 
