CREATE DATABASE EMPLOYEE_MANAGEMENT_AND_PERFORMANCE_ANALYTICS;
USE EMPLOYEE_MANAGEMENT_AND_PERFORMANCE_ANALYTICS;

CREATE TABLE EMPLOYEES (
EMP_ID INT PRIMARY KEY,
FULL_NAME VARCHAR(50),
GENDER VARCHAR(20),
DOB DATE,
DOJ DATE,
DEPT_ID INT,
DESIGNATION VARCHAR(30));

CREATE TABLE DEPARTMENTS (
DEPT_ID INT PRIMARY KEY,
DEPT_NAME VARCHAR(30));

CREATE TABLE PERFORMANCE (
EMP_ID INT PRIMARY KEY,
YEAR_ DATE,
RATING INT);

CREATE TABLE PROMOTIONS (
EMP_ID INT PRIMARY KEY,
PROMOTED_YEAR DATE,
NEW_DESIGNATIONS VARCHAR(30));

INSERT INTO EMPLOYEES 
VALUE
(101, 'Sarah Khan', 'F', '1990-03-12', '2015-06-10', 1, 'HR Manager'),
(102, 'Ali Raza', 'M', '1988-11-05', '2012-09-01', 2, 'Finance Analyst'),
(103, 'Maria Ahmed', 'F', '1992-07-22', '2018-03-15', 3, 'Software Engr'),
(104, 'Bilal Hussain', 'M','1995-05-30', '2020-01-10', '3', 'Junior Dev'),
(105, 'Mariam Siddiqui', 'F', '1989-01-11',	'2016-07-20', '2', 'Finance Manager'),
(106, 'Usman Malik', 'M', '1991-09-08', '2014-11-01', '1', 'Recruiter'),
(107, 'Zara Sheikh', 'F', '1993-12-25', '2017-10-11', '3', 'QA Engineer'),
(108, 'Imran Ashraf', 'M', '1987-08-18', '2011-05-01', '4',	'Sales Executive'),
(109, 'Hina Shah', 'F', '1994-04-14', '2019-08-30', '4', 'Sales Intern'),
(110, 'Saad Javed',	'M', '1996-02-19', '2021-02-01', '2', 'Accounts Officer');

INSERT INTO DEPARTMENTS
VALUE 
(1, 'Human Resource'),
(2, 'Finance'),
(3, 'IT'),
(4,	'Sales');

INSERT INTO PERFORMANCE
VALUE 
(101, '2023-01-01', 4),
(102, '2023-01-01', 3),
(103, '2023-01-01', 5),
(104, '2023-01-01', 2),
(105, '2023-01-01', 4),
(106, '2023-01-01', 3),
(107, '2023-01-01', 5),
(108, '2023-01-01', 3),
(109, '2023-01-01', 2),
(110, '2023-01-01', 4);

INSERT INTO PROMOTIONS
VALUE
(101, '2021-01-01', 'HR Manager'),
(102, '2015-01-01',	'Finance Analyst'),
(103, '2022-01-01', 'Software Engr'),
(105, '2018-01-01', 'Finance Manager'),
(106, '2019-01-01',	'Recruiter'),
(107, '2021-01-01',	'QA Engineer'),
(110, '2024-01-01',	'Sr. Accounts Off.');


-- Show total number of employees in each department.

SELECT d.DEPT_NAME, COUNT(e.EMP_ID) AS TOTAL_EMPLOYEES
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.DEPT_NAME;

-- List employees with a performance rating of 4 or above in 2023.

SELECT e.EMP_ID, e.FULL_NAME
FROM EMPLOYEES e
JOIN PERFORMANCE p ON e.EMP_ID = p.EMP_ID
WHERE RATING >= 4 AND YEAR_ = '2023-01-01';

-- How many male and female employees are there?

SELECT e.GENDER, COUNT(e.GENDER) AS TOTAL_GENDER
FROM EMPLOYEES e
GROUP BY GENDER;

-- Show all employees promoted in or after 2020.

SELECT e.EMP_ID, e.FULL_NAME
FROM EMPLOYEES e
JOIN PROMOTIONS pr ON e.EMP_ID = pr.EMP_ID
WHERE pr.PROMOTED_YEAR >= '2020-01-01';

-- List all employees with their department names and designations.

SELECT e.EMP_ID, e.FULL_NAME, d.DEPT_NAME, e.DESIGNATION
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPT_ID = d.DEPT_ID;

-- Identify top 3 performers based on 2023 ratings.

SELECT e.EMP_ID, e.FULL_NAME, p.RATING
FROM EMPLOYEES e 
JOIN PERFORMANCE p ON e.EMP_ID = p.EMP_ID
WHERE p.YEAR_= '2023-01-01'
ORDER BY p.RATING DESC
LIMIT 3;

-- Find employees who have never been promoted.

SELECT e.EMP_ID, e.FULL_NAME
FROM EMPLOYEES e 
LEFT JOIN PROMOTIONS p ON e.EMP_ID = p.EMP_ID
WHERE p.EMP_ID IS NULL;

-- Show the average performance rating per department.

SELECT d.DEPT_NAME, AVG(pro.RATING) AS AVG_RATING
FROM EMPLOYEES e
JOIN PERFORMANCE pro ON e.EMP_ID = pro.EMP_ID
JOIN DEPARTMENTS d ON e.DEPT_ID = d.DEPT_ID
WHERE YEAR_ = '2023-01-01'
GROUP BY d.DEPT_NAME; 

-- List employees who joined before 2015.

SELECT EMP_ID, FULL_NAME
FROM EMPLOYEES
WHERE DOJ < '2015-01-01';

-- Find the youngest employee in each department.

SELECT d.DEPT_NAME, e.FULL_NAME, e.DOB
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPT_ID = d.DEPT_ID
WHERE (e.DEPT_ID, e.DOB) IN (
	SELECT DEPT_ID, MAX(DOB)
    FROM EMPLOYEES
    GROUP BY DEPT_ID
);




















