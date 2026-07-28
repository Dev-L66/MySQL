-- GROUP BY

SELECT *
FROM employee_demographics;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- ORDER BY
SELECT *
FROM employee_demographics
ORDER BY gender, age; -- BY default it is ASC order


-- HAVING VS WHERE

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

-- Aliasing 
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

SELECT gender, AVG(age)  avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;



