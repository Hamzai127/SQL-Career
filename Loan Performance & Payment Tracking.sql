CREATE DATABASE LOAN_PERFORMANCE;
USE LOAN_PERFORMANCE;

-- Total payment per loan

SELECT loan_id, SUM(amount_paid) AS total_amount_paid
FROM payments
GROUP BY loan_id
ORDER BY total_amount_paid;

-- Loans with payments above the average payment

SELECT loan_id, amount
FROM loans
WHERE amount > (
	SELECT AVG(amount_paid) AS Avg_paid
	FROM payments);

-- Risk categorization based on loan status

SELECT 
loan_id,
status,
	CASE 
		WHEN status = 'Defaulted' THEN 'High Risk'
        WHEN status = 'Delayed' THEN 'Medium risk'
        ELSE 'Low Risk'
	END AS Risk_Category
FROM loans;

-- Payment method transformation

SELECT payment_id,
REPLACE(UPPER(payment_mode), 'CHEQUE', 'OFFLINE') AS rev_payment_mode
FROM payments;

-- Loan issue month

SELECT loan_id, issue_date,
SUBSTRING(issue_date,6,2) AS Loan_month
FROM loans;

-- Payments where mode contains ‘cash’

SELECT payment_id
FROM payments
WHERE LOCATE('CASH', payment_mode) > 0;

-- JOIN loans and payments with LEFT JOIN to include unpaid loans

SELECT
l.loan_id,
l.loan_type,
p.amount_paid,
p.payment_mode
FROM loans l
LEFT JOIN payments p ON l.loan_id=p.loan_id;








	
