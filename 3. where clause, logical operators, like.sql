-- WHERE CLAUSE

SELECT *
FROM employee_salary
WHERE first_name = "Leslie";

SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM employee_salary
WHERE salary < 50000;

SELECT *
FROM employee_salary
WHERE salary <= 50000;


SELECT *
FROM employee_demographics
WHERE gender = "Male";

SELECT *
FROM employee_demographics
WHERE gender != "Male";

-- AND OR NOT -- LOGICAL OPERATORS
SELECT *
FROM employee_demographics
WHERE birth_date > '1980-01-01'
AND gender = "Male";

SELECT *
FROM employee_demographics
WHERE birth_date > '1980-01-01'
OR gender = "Male";

SELECT *
FROM employee_demographics
WHERE birth_date > '1980-01-01'
OR NOT gender = "Male";

SELECT *
FROM employee_demographics
WHERE (first_name = "Leslie" AND age = 44);


SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';


SELECT *
FROM employee_demographics
WHERE birth_date LIKE'1989%';
