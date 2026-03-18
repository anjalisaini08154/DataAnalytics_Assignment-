--Assignment 4 – SQL


CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC,
    department VARCHAR(50),
    job_role VARCHAR(50),
    commission NUMERIC
);

INSERT INTO employees (name, salary, department, job_role, commission)
VALUES
('Amit', 60000, 'IT', 'Developer', NULL),
('Neha', 45000, 'HR', 'HR Executive', 2000);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    region VARCHAR(50),
    amount NUMERIC
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    marks INT
);

/*1. Write an SQL query to display the names and salaries of employees 
   whose salary is greater than the average salary in the company. 
   Explain how the subquery works. */

  -- ANS: The subquery calculates the average salary of all employees in the company.
        --The main query compares each employee’s salary with the average value returned by the subquery and displays only those employees whose salary is greater than the average salary.

         SELECT name, salary
         FROM employees
         WHERE salary > (
         SELECT AVG(salary)
         FROM employees
        );


/*2. Write a query to retrieve the top 5 highest-paid employees from an 
    employees table. 
    Explain how sorting affects the output.*/

    /*ANS: The ORDER BY salary DESC clause sorts the employee records in descending order based on salary, meaning the highest salaries appear first in the result set.
         The LIMIT 5 clause then restricts the output to only the top five highest-paid employees.*/

         SELECT name, salary
         FROM employees
         ORDER BY salary DESC
         LIMIT 5;


/*3. Write a query to calculate: 
   • Total number of employees 
   • Average salary 
   • Minimum and maximum salary  
   Explain the difference between aggregate and scalar functions. */

   /*ANS: Aggregate functions perform calculations on multiple rows and return a single result, such as COUNT, AVG, MIN, and MAX.
        Scalar functions operate on individual values and return one result for each row.*/

        SELECT
        COUNT(*) AS total_employees,
        AVG(salary) AS average_salary,
        MIN(salary) AS minimum_salary,
        MAX(salary) AS maximum_salary
        FROM employees;


/*4. Given a sales table with columns (region, amount), write a query to find 
   total sales per region. 
   Filter only those regions where total sales exceed 50,000. */

  /* ANS: The GROUP BY clause groups sales records by region and calculates the total sales using the SUM function.
        The HAVING clause is used to filter the grouped results and returns only those regions where the total sales exceed 50,000.*/

        SELECT region, SUM(amount) AS total_sales
        FROM sales
        GROUP BY region
        HAVING SUM(amount) > 50000;


/*5. Write a query to find the number of unique job roles in an employees 
   table. 
   Explain why DISTINCT is necessary here.*/

   /*ANS: The DISTINCT keyword removes duplicate job roles from the table before counting.
        Without using DISTINCT, repeated job roles would be counted multiple times, resulting in an incorrect count.*/

        SELECT COUNT(DISTINCT job_role) AS unique_job_roles
        FROM employees;


/*6. Write a query to retrieve students who scored between 60 and 80 
   marks. 
   Rewrite the same query using BETWEEN.*/

   /*ANS: The first query uses comparison operators to check the range of marks.
        The BETWEEN operator provides a more readable way to retrieve values that fall within a specified range and includes both boundary values.*/

        SELECT *
        FROM students
        WHERE marks >= 60 AND marks <= 80;

        SELECT *
        FROM students
        WHERE marks BETWEEN 60 AND 80;


/*7. Write a query to display employees whose commission is NULL. 
   Explain the correct way to check NULL values in SQL. */

  /* ANS: NULL represents missing or unknown values in a database.
        In SQL, NULL values cannot be compared using the = operator.
        The correct way to check for NULL values is by using IS NULL.*/

        SELECT *
        FROM employees
        WHERE commission IS NULL;


/*8. Write a query to increase the salary of employees in the “IT” 
   department by 10%. 
   Explain how arithmetic operations are handled in SQL.*/

   /*ANS: SQL supports arithmetic operations such as addition, subtraction, multiplication, and division directly within queries.
        In this query, the salary is multiplied by 1.10 to increase it by 10% for employees working in the IT department.*/

        UPDATE employees
        SET salary = salary * 1.10
        WHERE department = 'IT';


/*9. Write a query to delete records of students who scored less than 40 
   marks. 
   What precaution should be taken before executing DELETE? */

  /* ANS: Before executing a DELETE statement, a SELECT query with the same condition should be run to verify the records that will be removed.
        This precaution helps prevent accidental deletion of important data.*/

        DELETE FROM students
        WHERE marks < 40;


/*10. Write a query to find employees who earn more than the average 
    salary of their department (without using joins). 
    Explain the logic of the subquery. */

    /*ANS: This query uses a correlated subquery to calculate the average salary for each department.
        For every employee in the main query, the subquery computes the average salary of the department to which that employee belongs.
        The main query then compares the employee’s salary with the department’s average salary and returns only those employees whose salary is higher than the average.*/

        SELECT name, salary, department
        FROM employees e
        WHERE salary > (
        SELECT AVG(salary)
        FROM employees
        WHERE department = e.department
        );