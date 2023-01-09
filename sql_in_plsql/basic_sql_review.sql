
--Limiting Aggregate Functions to Rows that Satisfy a Condition
SELECT DEPARTMENT_ID "Department",
SUM(SALARY*12) "All Salaries"
FROM EMPLOYEES
HAVING SUM(SALARY * 12) >= 1000000
GROUP BY DEPARTMENT_ID;

--Using Aggregate Functions for Statistical Information
SELECT JOB_ID,
COUNT(*) "#",
MIN(SALARY) "Minimum",
ROUND(AVG(SALARY), 0) "Average",
MEDIAN(SALARY) "Median",
MAX(SALARY) "Maximum",
ROUND(STDDEV(SALARY)) "Std Dev"
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

--Using a Searched CASE Expression in a Query
SELECT LAST_NAME "Name",
HIRE_DATE "Started",
SALARY "Salary",
CASE
  WHEN HIRE_DATE < TO_DATE('01-Jan-90', 'dd-mon-yy')
    THEN TRUNC(SALARY*1.15, 0)
  WHEN HIRE_DATE < TO_DATE('01-Jan-95', 'dd-mon-yy')
    THEN TRUNC(SALARY*1.10, 0)
  WHEN HIRE_DATE < TO_DATE('01-Jan-00', 'dd-mon-yy')
    THEN TRUNC(SALARY*1.05, 0)
  ELSE SALARY
END "Proposed Salary"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100
ORDER BY HIRE_DATE;

--Using the DECODE Function in a Query
SELECT LAST_NAME, JOB_ID, SALARY,
DECODE(JOB_ID,
  'PU_CLERK', SALARY * 1.10,
  'SH_CLERK', SALARY * 1.15,
  'ST_CLERK', SALARY * 1.20,
  SALARY) "Proposed Salary"
FROM EMPLOYEES
WHERE JOB_ID LIKE '%_CLERK'
AND LAST_NAME < 'E'
ORDER BY LAST_NAME;

--//// SELECT ////

--Simple Query Examples:

--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10002.htm#i2066378

--The following statement selects rows from the employees table with the department number of 30:

SELECT * 
   FROM employees 
   WHERE department_id = 30
   ORDER BY last_name;

--The following statement selects the name, job, salary and department number of all employees except purchasing clerks from department number 30:

SELECT last_name, job_id, salary, department_id 
   FROM employees 
   WHERE NOT (job_id = 'PU_CLERK' AND department_id = 30)
   ORDER BY last_name; 

--The following statement selects from subqueries in the FROM clause and for each department returns the total employees and salaries as a decimal value of all the departments:

SELECT a.department_id "Department",
   a.num_emp/b.total_count "%_Employees",
   a.sal_sum/b.total_sal "%_Salary"
FROM
(SELECT department_id, COUNT(*) num_emp, SUM(salary) sal_sum
   FROM employees
   GROUP BY department_id) a,
(SELECT COUNT(*) total_count, SUM(salary) total_sal
   FROM employees) b
ORDER BY a.department_id;

--Selecting from a Partition: 

--You can select rows from a single partition of a partitioned table by specifying the keyword PARTITION in the FROM clause. 

--This SQL statement assigns an alias for and retrieves rows from the sales_q2_2000 partition of the sample table sh.sales:

SELECT * FROM sales PARTITION (sales_q2_2000) s
   WHERE s.amount_sold > 1500
   ORDER BY cust_id, time_id, channel_id;

--The following example selects rows from the oe.orders table for orders earlier than a specified date:

SELECT * FROM orders
   WHERE order_date < TO_DATE('2000-06-15', 'YYYY-MM-DD');


--//// INSERT ////

--https://docs.oracle.com/cd/B12037_01/server.101/b10759/statements_9014.htm#i2145081

--Inserting Values into Tables: Examples
--The following statement inserts a row into the sample table departments:

INSERT INTO departments
   VALUES (280, 'Recreation', 121, 1700);

--If the departments table had been created with a default value of 121 for the manager_id column, then you could issue the same statement as follows:

INSERT INTO departments
   VALUES (280, 'Recreation', DEFAULT, 1700);

--The following statement inserts a row with six columns into the employees table. One of these columns is assigned NULL and another is assigned a number in scientific notation:

INSERT INTO employees (employee_id, last_name, email, 
      hire_date, job_id, salary, commission_pct) 
   VALUES (207, 'Gregory', 'pgregory@oracle.com', 
      sysdate, 'PU_CLERK', 1.2E3, NULL);

--The following statement has the same effect as the preceding example, but uses a subquery in the DML_table_expression_clause:

INSERT INTO 
   (SELECT employee_id, last_name, email, hire_date, job_id, 
      salary, commission_pct FROM employees) 
   VALUES (207, 'Gregory', 'pgregory@oracle.com', 
      sysdate, 'PU_CLERK', 1.2E3, NULL);

--More examples:

https://docs.oracle.com/cd/B12037_01/server.101/b10759/statements_9014.htm#i2145081

--//// UPDATE ////

--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10007.htm

--Examples: https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10007.htm#i2189756

--Updating a Table: Examples 
--The following statement gives null commissions to all employees with the job SH_CLERK:

UPDATE employees
   SET commission_pct = NULL
   WHERE job_id = 'SH_CLERK';

--The following statement promotes Douglas Grant to manager of Department 20 with a $1,000 raise:

UPDATE employees SET 
    job_id = 'SA_MAN', salary = salary + 1000, department_id = 120 
    WHERE first_name||' '||last_name = 'Douglas Grant'; 

--The following statement increases the salary of an employee in the employees table on the remote database:

UPDATE employees@remote
   SET salary = salary*1.1
   WHERE last_name = 'Baer';

--The next example shows the following syntactic constructs of the UPDATE statement:

--Both forms of the update_set_clause together in a single statement

--A correlated subquery

--A where_clause to limit the updated rows

UPDATE employees a 
    SET department_id = 
        (SELECT department_id 
            FROM departments 
            WHERE location_id = '2100'), 
        (salary, commission_pct) = 
        (SELECT 1.1*AVG(salary), 1.5*AVG(commission_pct) 
          FROM employees b 
          WHERE a.department_id = b.department_id) 
    WHERE department_id IN 
        (SELECT department_id 
          FROM departments
          WHERE location_id = 2900 
              OR location_id = 2700); 

--The preceding UPDATE statement performs the following operations:

--Updates only those employees who work in Geneva or Munich (locations 2900 and 2700)

--Sets department_id for these employees to the department_id corresponding to Bombay (location_id 2100)

--Sets each employee's salary to 1.1 times the average salary of their department

--Sets each employee's commission to 1.5 times the average commission of their department

--Updating a Partition: Example 
--The following example updates values in a single partition of the sales table:

UPDATE sales PARTITION (sales_q1_1999) s
   SET s.promo_id = 494
   WHERE amount_sold > 1000;

--//// DELETE ////

--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8005.htm

--Deleting Rows: Examples 
--The following statement deletes all rows from the sample table oe.product_descriptions where the value of the language_id column is AR:

DELETE FROM product_descriptions
   WHERE language_id = 'AR';

--The following statement deletes from the sample table hr.employees purchasing clerks whose commission rate is less than 10%:

DELETE FROM employees
   WHERE job_id = 'SA_REP'
   AND commission_pct < .2;

--The following statement has the same effect as the preceding example, but uses a subquery:

DELETE FROM (SELECT * FROM employees)
   WHERE job_id = 'SA_REP'
   AND commission_pct < .2;

--Further reading: 
--https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8005.htm#i2143613

--//// Transactions ////

--https://docs.oracle.com/database/121/CNCPT/transact.htm#CNCPT037


COMMIT;
--This statement ends any existing transaction in the session.

SET TRANSACTION NAME 'sal_update';
--This statement begins a transaction and names it sal_update.

UPDATE employees
    SET salary = 7000 
    WHERE last_name = 'Banda';
--This statement updates the salary for Banda to 7000.

SAVEPOINT after_banda_sal;
--This statement creates a savepoint named after_banda_sal, enabling changes in this transaction to be rolled back to this point.

UPDATE employees
    SET salary = 12000 
    WHERE last_name = 'Greene';
--This statement updates the salary for Greene to 12000.

SAVEPOINT after_greene_sal;
--This statement creates a savepoint named after_greene_sal, enabling changes in this transaction to be rolled back to this point.

ROLLBACK TO SAVEPOINT
    after_banda_sal;
--This statement rolls back the transaction to t3, undoing the update to Greene's salary at t4. The sal_update transaction has not ended.

UPDATE employees
    SET salary = 11000 
    WHERE last_name = 'Greene';
--This statement updates the salary for Greene to 11000 in transaction sal_update.

ROLLBACK;
--This statement rolls back all changes in transaction sal_update, ending the transaction.

SET TRANSACTION NAME 'sal_update2';
--This statement begins a new transaction in the session and names it sal_update2.

UPDATE employees
    SET salary = 7050 
    WHERE last_name = 'Banda';
--This statement updates the salary for Banda to 7050.

UPDATE employees
    SET salary = 10950 
    WHERE last_name = 'Greene';
--This statement updates the salary for Greene to 10950.

COMMIT;
--This statement commits all changes made in transaction sal_update2, ending the transaction. The commit guarantees that the changes are saved in the online redo log files.