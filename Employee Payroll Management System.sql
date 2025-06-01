// Project: Employee Payroll Management System (PostgreSQL)//

Create database Payroll_DB

// Create a table employees //

use payroll_DB

CREATE TABLE employees (
    EMPLOYEE_ID INT PRIMARY KEY,
    NAME TEXT,
    DEPARTMENT TEXT,
    EMAIL TEXT,
    PHONE_NO NUMERIC,
    JOINING_DATE DATE,
    SALARY NUMERIC,
    BONUS NUMERIC,
    TAX_PERCENTAGE NUMERIC
)

INSERT INTO employees VALUES
(1, 'Antony', 'Design', 'Antony@amazon.com', 1234567890, '2024-08-10', 40000, 10000, 15),
(2, 'Preethi', 'IT', 'Preethi@amazon.com', 1234567891, '2023-05-01', 50000, 5000, 20),
(3, 'Gokul', 'Admin', 'Gokul@amazon.com', 1234567892, '2023-08-15', 200000, 3000, 15),
(4, 'Krishna', 'Finance', 'Krishna@amazon.com', 1234567893, '2025-02-20', 45000, 7000, 20),
(5, 'Pravin', 'Sales', 'Pravin@amazon.com', 1234567894, '2023-09-05', 60000, 5000, 10),
(6, 'Sakthi', 'Quality', 'Sakthi@amazon.com', 1234567895, '2023-05-25', 30000, 8000, 20),
(7, 'Raj', 'Production', 'Raj@amazon.com', 1234567896, '2024-09-01', 67000, 4000, 15),
(8, 'Yogi', 'Marketing', 'Yogi@amazon.com', 1234567897, '2025-01-28', 75000, 6000, 15),
(9, 'Sai', 'Procurement', 'Sai@amazon.com', 1234567898, '2023-09-10', 62000, 3000, 20),
(10, 'Vyshakh', 'HR', 'Vyshakh@amazon.com', 1234567899, '2024-07-01', 56000, 2000, 15);

Select * From employees

// Retrieve the list of employees sorted by salary in descending order //

Select * from employees
order by salary desc;


// Find employees with a total compensation (SALARY + BONUS) greater than 
$100,000 //

Select *, (Salary + Bonus) As Total_compensation
from employees
Where (Salary + Bonus) > 100000;

// Update the bonus for employees in the ‘Sales’ department by 10% //

SET SQL_SAFE_UPDATES = 0;

Update employees 
set Bonus = Bonus * 1.10
Where Department = 'sales';
select * from employees;

// Calculate the net salary after deducting tax for all employees //

SELECT EMPLOYEE_ID, NAME, SALARY, BONUS, TAX_PERCENTAGE,
    (SALARY + BONUS) * (1 - TAX_PERCENTAGE / 100.0) AS NET_SALARY
FROM employees;

// Retrieve the average, minimum, and maximum salary per department //

SELECT 
    DEPARTMENT,
    ROUND(AVG(SALARY), 2) AS AVG_SALARY,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;

// Advanced Queries: //
// Retrieve employees who joined in the last 6 months //

SELECT *
FROM employees
WHERE JOINING_DATE >= CURRENT_DATE - INTERVAL 6 MONTH;

// Group employees by department and count how many employees each has //

SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM employees
GROUP BY DEPARTMENT;

// Find the department with the highest average salary //

SELECT DEPARTMENT, AVG(SALARY) AS AVERAGE_SALARY
FROM employees
GROUP BY DEPARTMENT;


// Identify employees who have the same salary as at least one other employee //

SELECT * FROM employees
WHERE SALARY IN (
    SELECT SALARY
    FROM employees
    GROUP BY SALARY
    HAVING COUNT(*) > 1);