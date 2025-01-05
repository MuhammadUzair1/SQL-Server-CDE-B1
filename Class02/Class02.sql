--------- SQL Class 02 ---------
--------- Hands-on with SELECT WHERE FROM OE ---------

-- CREATE DATABASE BikeStores;

USE BikeStores;

-- Selecting all data from the customers table
-- * means all coulmns 
-- sales refers to the schema
-- customers is the table in the schema
select * from sales.customers;

-- specifying columns that I need instead of all
select first_name, last_name, street, city from sales.customers;

-- filtering rows
select customer_id, first_name, last_name, street, city 
from sales.customers
where city = 'Houston';

-- Sorting the data on first_name
select customer_id, first_name, last_name, street, city 
from sales.customers
where city = 'Houston'
order by first_name;

-- Sorting data on first_name in descending order
select customer_id, first_name, last_name, street, city 
from sales.customers
where city = 'Houston'
order by first_name desc;

-- Head data using TOP
select top 5 customer_id, first_name, last_name, street, city 
from sales.customers;

--ORDER OF EXECUTION
-- 1. FROM 
-- 2. WHERE
-- 3. SELECT
-- 4. LIMIT

--GROUP BY
SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
ORDER BY
    city;
--ORDER OF EXECUTION
-- 1. FROM 
-- 2. WHERE
-- 3. GROUP BY 
-- 4. SELECT
-- 5. ORDER BY

-- GROUP BY WITH HAVING
SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city DESC;
-- ORDER OF EXECUTION
-- 1. FROM
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. ORDER BY

-- #6+7   SELECT DISTINCT department_id                                 
-- #1     FROM employees                                                
-- #2     JOIN orders ON customers.customer_id = orders.customer_id     
-- #3     WHERE salary > 3000                                          
-- #4     GROUP BY department 
-- #5     HAVING AVG(salary) > 5000 
-- #8     ORDER BY department 
-- #9     LIMIT 10 OFFSET 5 
-- #10    OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY; 

------ ORDER BY
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name;

-- ORDER BY ON COLUMN THAT IS NOT IN SELECT
SELECT
    city,
    first_name,
    last_name,
	state
FROM
    sales.customers
ORDER BY
    state;

-- ORDER BY on Len of first_name words
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;


SELECT
    first_name,
    last_name,
FROM
    sales.customers
ORDER BY
    1,
    2;

-- OFFSET FETCH
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name;

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS -- Will not include first 10 rows in the final answer
FETCH NEXT 10 ROWS ONLY; -- will provide only next 10 rows


SELECT
	top 10
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name

SELECT TOP 1 PERCENT -- if there are 500 hundred rows then it will display 1% rows (5 rows only)
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

-- NUMBER OF ROWS IN THE TABLE
SELECT COUNT(*) FROM production.products;

-- EXPLAIN IT
SELECT TOP 3 WITH TIES
    city, 
    state
FROM
    sales.customers
ORDER BY 
    city DESC;

-- SELECT DISTINCT
SELECT DISTINCT state 
FROM sales.customers;

-- WHERE
/*
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition;
*/

SELECT 
	product_id, product_name, model_year, list_price
FROM 
	production.products
WHERE
	model_year > 2018
ORDER BY 
	list_price;

-- AND OPERATOR
SELECT 
	product_id, product_name, model_year, list_price
FROM 
	production.products
WHERE
	(model_year > 2018) AND (list_price <3000)
ORDER BY 
	list_price;

-- OR OPERATOR
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 3000 OR model_year = 2018
ORDER BY
    list_price DESC;

-- BETWEEN
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
    list_price DESC;

-- IN
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price IN (1999.99, 3199.99, 3000.99)
ORDER BY
    list_price DESC;

-- LIKE
SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Cruiser%'
ORDER BY
    list_price;

-- MAGIC KEYWORD
-- %
-- ANYTHING CAN BE HERE

-- STARTING WITH 'z'
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;

-- ENDING WITH 'er'
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%er'
ORDER BY
    first_name;

-- WILDCARD '_'
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '_un%' --First letter can be anything but after it there much be un endign can be anthing
ORDER BY
    first_name;

-- Wildcard []
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[U-Z]%' --Starting with u to z aplphabets
ORDER BY
    last_name;

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[yz]%' --Starting with either y or z
ORDER BY
    last_name;

-- WILDCARD '^' meaning not
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[^A-X]%'
ORDER BY
    last_name;

-- NOT LIKE
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    first_name NOT LIKE 'A%'
ORDER BY
    first_name;

CREATE TABLE sales.feedbacks (
  feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
  comment VARCHAR(255) NOT NULL
);

INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');

SELECT * FROM sales.feedbacks;

-- ESCAPE SEQUENCE IN SQL LIKE
SELECT 
   feedback_id,
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30%';

SELECT 
   feedback_id,
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30@%%' ESCAPE '@';

-- SQL ALIAS
SELECT
    first_name + ' ' + last_name AS Full_Name
FROM
    sales.customers
ORDER BY
    first_name;

SELECT
    first_name + ' ' + last_name AS 'Full Name'
FROM
    sales.customers
ORDER BY
    first_name;


