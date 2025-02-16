-- CTE (Common Table Expressions)
-- Temporary Tables
-- SELECT, UPDATE, INSERT, DELETE, MERGE

/*
WITH expression_name[(column_name [,...])]
AS
    (CTE_definition)
SQL_statement;
*/

-- Sales by each staff member in 2018
WITH cte_sales_amount (Full_Name, Sale_Amount, year) AS (
    SELECT 
        first_name + ' ' + last_name AS Full_Name,
        SUM(quantity * list_price * (1 - discount)) AS Sale_Amount,
        YEAR(order_date) AS year
    FROM 
        sales.orders O
    JOIN
        sales.staffs s ON s.staff_id = o.staff_id
    JOIN
        sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        first_name + ' ' + last_name, YEAR(order_date)
)
SELECT * FROM cte_sales_amount;

-- Average number of sale orders in year 2018
WITH cte_order_count AS (
    SELECT
        staff_id, COUNT(DISTINCT order_id) AS order_count
    FROM 
        sales.orders
    WHERE YEAR(order_date) = 2018
    GROUP BY 
        staff_id
)
SELECT AVG(order_count) AS Average_orders FROM cte_order_count;

-- Product prices by year
WITH product_price_cte (product_name, list_price, year) AS (
    SELECT 
        product_name, 
        SUM(list_price) AS list_price, 
        model_year AS year
    FROM 
        production.products
    GROUP BY 
        product_name, model_year
)
SELECT * FROM product_price_cte;

-- Category counts and sales
WITH cte_category_counts (category_id, category_name, product_count) AS (
    SELECT 
        c.category_id, 
        c.category_name, 
        COUNT(p.product_id) AS product_count
    FROM 
        production.products p
    INNER JOIN 
        production.categories c ON c.category_id = p.category_id
    GROUP BY 
        c.category_id, c.category_name
),
cte_category_sales (category_id, sales) AS (
    SELECT    
        p.category_id, 
        SUM(i.quantity * i.list_price * (1 - i.discount)) AS sales
    FROM    
        sales.order_items i
    INNER JOIN 
        production.products p ON p.product_id = i.product_id
    INNER JOIN 
        sales.orders o ON o.order_id = i.order_id
    WHERE 
        order_status = 4 -- completed
    GROUP BY 
        p.category_id
) 
SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
INNER JOIN 
    cte_category_sales s ON s.category_id = c.category_id
ORDER BY 
    c.category_name;

-- RECURSIVE CTE
-- Generate numbers and weekdays
WITH cte_numbers (n, weekday) AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n < 6
)
SELECT 
    weekday
FROM 
    cte_numbers;

-- Organizational hierarchy
WITH cte_org AS (
    SELECT       
        staff_id, 
        first_name,
        manager_id
    FROM       
        sales.staffs
    WHERE 
        manager_id IS NULL
    UNION ALL
    SELECT 
        e.staff_id, 
        e.first_name,
        e.manager_id
    FROM 
        sales.staffs e
    INNER JOIN 
        cte_org o ON o.staff_id = e.manager_id
)
SELECT * FROM cte_org;

-- PIVOT
-- Pivot table to count products by category
SELECT * FROM   
(
    SELECT 
        category_name, 
        product_id
    FROM 
        production.products p
    INNER JOIN 
        production.categories c ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN (
        [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes]
    )
) AS pivot_table;

-- DATA DEFINITION LANGUAGE (DDL)
-- Create a new database
CREATE DATABASE tesTdB;

-- List all databases
SELECT 
    name 
FROM 
    master.sys.databases
ORDER BY
    name;

-- Drop database if exists
DROP DATABASE IF EXISTS SampleDb;

-- Use the new database
USE tesTdB;

-- Create a new schema
CREATE SCHEMA Customer_services;

-- Create a new table in the schema
CREATE TABLE customer_services.jobs (
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    CREATED_At DATETIME2 NOT NULL
);

-- Create another table in dbo schema
CREATE TABLE dbo.offices (
    office_id INT PRIMARY KEY IDENTITY,
    OFFICE_NAME NVARCHAR(40) NOT NULL,
    OFFICE_address NVARCHAR(255) NOT NULL,
    PHONE VARCHAR(20)
);

-- Insert data into dbo.offices
INSERT INTO dbo.offices (office_name, office_address)
VALUES
    ('Silicon Valley', '400 North 1st Street, San Jose, CA 95130'),
    ('Sacramento', '1070 River Dr., Sacramento, CA 95820');

-- Select data from dbo.offices
SELECT * FROM dbo.offices;

-- Transfer dbo.offices to customer_services schema
ALTER SCHEMA customer_services TRANSFER OBJECT::dbo.offices;

-- Create a new schema
CREATE SCHEMA KARACHI;

-- Create a new table in KARACHI schema
CREATE TABLE KARACHI.SAYLANI (
    saylani_id INT PRIMARY KEY IDENTITY,
    branch_NAME NVARCHAR(40) NOT NULL,
    branch_address NVARCHAR(255) NOT NULL,
    PHONE VARCHAR(20)
);

-- Insert data into KARACHI.SAYLANI
INSERT INTO KARACHI.SAYLANI (branch_NAME, branch_address)
VALUES
    ('Silicon Valley', '400 North 1st Street, San Jose, CA 95130');

-- Select data from KARACHI.SAYLANI
SELECT * FROM KARACHI.SAYLANI;

-- Drop schema if exists
DROP SCHEMA IF EXISTS KARACHI;

-- List all schemas
SELECT name 
FROM SYS.schemas;

-- Use BikeStores database
USE BikeStores;

-- Create a new table in sales schema
CREATE TABLE sales.taxes (
    tax_id INT PRIMARY KEY IDENTITY (1, 1),
    state VARCHAR(50) NOT NULL UNIQUE,
    state_tax_rate DEC(3, 2),
    avg_local_tax_rate DEC(3, 2),
    combined_rate AS state_tax_rate + avg_local_tax_rate,
    max_local_tax_rate DEC(3, 2),
    updated_at DATETIME
);

-- Insert data into sales.taxes
INSERT INTO sales.taxes (state, state_tax_rate, avg_local_tax_rate, max_local_tax_rate) VALUES
    ('Alabama', 0.04, 0.05, 0.07),
    ('Alaska', 0, 0.01, 0.07),
    ('Arizona', 0.05, 0.02, 0.05),
    ('Arkansas', 0.06, 0.02, 0.05),
    ('California', 0.07, 0.01, 0.02),
    ('Colorado', 0.02, 0.04, 0.08),
    ('Connecticut', 0.06, 0, 0),
    ('Delaware', 0, 0, 0),
    ('Florida', 0.06, 0, 0.02),
    ('Georgia', 0.04, 0.03, 0.04),
    ('Hawaii', 0.04, 0, 0),
    ('Idaho', 0.06, 0, 0.03),
    ('Illinois', 0.06, 0.02, 0.04),
    ('Indiana', 0.07, 0, 0),
    ('Iowa', 0.06, 0, 0.01),
    ('Kansas', 0.06, 0.02, 0.04),
    ('Kentucky', 0.06, 0, 0),
    ('Louisiana', 0.05, 0.04, 0.07),
    ('Maine', 0.05, 0, 0),
    ('Maryland', 0.06, 0, 0),
    ('Massachusetts', 0.06, 0, 0),
    ('Michigan', 0.06, 0, 0),
    ('Minnesota', 0.06, 0, 0.01),
    ('Mississippi', 0.07, 0, 0.01),
    ('Missouri', 0.04, 0.03, 0.05),
    ('Montana', 0, 0, 0),
    ('Nebraska', 0.05, 0.01, 0.02),
    ('Nevada', 0.06, 0.01, 0.01),
    ('New Hampshire', 0, 0, 0),
    ('New Jersey', 0.06, 0, 0),
    ('New Mexico', 0.05, 0.02, 0.03),
    ('New York', 0.04, 0.04, 0.04),
    ('North Carolina', 0.04, 0.02, 0.02),
    ('North Dakota', 0.05, 0.01, 0.03),
    ('Ohio', 0.05, 0.01, 0.02),
    ('Oklahoma', 0.04, 0.04, 0.06),
    ('Oregon', 0, 0, 0),
    ('Pennsylvania', 0.06, 0, 0.02),
    ('Rhode Island', 0.07, 0, 0),
    ('South Carolina', 0.06, 0.01, 0.02),
    ('South Dakota', 0.04, 0.01, 0.04),
    ('Tennessee', 0.07, 0.02, 0.02),
    ('Texas', 0.06, 0.01, 0.02),
    ('Utah', 0.05, 0, 0.02),
    ('Vermont', 0.06, 0, 0.01),
    ('Virginia', 0.05, 0, 0),
    ('Washington', 0.06, 0.02, 0.03),
    ('West Virginia', 0.06, 0, 0.01),
    ('Wisconsin', 0.05, 0, 0.01),
    ('Wyoming', 0.04, 0.01, 0.02),
    ('D.C.', 0.05, 0, 0);

-- Update the updated_at column with the current date and time
UPDATE sales.taxes
SET updated_at = GETDATE();

-- Select all data from sales.taxes
SELECT * FROM sales.taxes;

-- Update specific rows in sales.taxes
UPDATE sales.taxes
SET max_local_tax_rate += 0.02,
    avg_local_tax_rate += 0.01
WHERE
    max_local_tax_rate = 0.01;

-- UPDATE JOINS
-- Drop table if exists
DROP TABLE IF EXISTS sales.targets;

-- Create a new table in sales schema
CREATE TABLE sales.targets (
    target_id INT PRIMARY KEY IDENTITY,
    percentage DECIMAL(4, 2) NOT NULL DEFAULT 0
);

-- Insert data into sales.targets
INSERT INTO sales.targets (percentage)
VALUES
    (0.2),
    (0.3),
    (0.5),
    (0.7);

-- Select all data from sales.targets
SELECT * FROM sales.targets;

-- Delete top 10 rows from sales.taxes
DELETE TOP (10) FROM sales.taxes;

-- Create a new table in sales schema
CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2)
);

-- Insert data into sales.category
INSERT INTO sales.category (category_id, category_name, amount)
VALUES
    (1, 'Children Bicycles', 15000),
    (2, 'Comfort Bicycles', 25000),
    (3, 'Cruisers Bicycles', 13000),
    (4, 'Cyclocross Bicycles', 10000);

-- Create a new table in sales schema
CREATE TABLE sales.category_staging (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2)
);

-- Insert data into sales.category_staging
INSERT INTO sales.category_staging (category_id, category_name, amount)
VALUES
    (1, 'Children Bicycles', 15000),
    (3, 'Cruisers Bicycles', 13000),
    (4, 'Cyclocross Bicycles', 20000),
    (5, 'Electric Bikes', 10000),
    (6, 'Mountain Bikes', 10000);

-- Merge data from sales.category_staging into sales.category
MERGE sales.category t 
USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED THEN 
    UPDATE SET 
        t.category_name = s.category_name,
        t.amount = s.amount
WHEN NOT MATCHED BY TARGET THEN 
    INSERT (category_id, category_name, amount)
    VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE THEN 
    DELETE;

-- Select all data from sales.category
SELECT * FROM sales.category;
