---------- JOINS ----------

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

-- Inserting Data
INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

SELECT * FROM hr.candidates;

SELECT * FROM hr.employees;

-- inner join
select c.id, c.fullname
from hr.candidates c
join hr.employees e on  
c.fullname = e.fullname;

-- left join
select c.id, c.fullname, e.id as employee_id, e.fullname as employee_name
from hr.candidates c
left join hr.employees e on  
c.fullname = e.fullname;

-- left outer join
select c.id, c.fullname, e.id as employee_id, e.fullname as employee_name
from hr.candidates c
left; join hr.employees e on  
c.fullname = e.fullname
where e.id is null;

-- Right join
select e.id, e.fullname
from hr.candidates c
Right join hr.employees e on  
c.fullname = e.fullname
where c.id is null;

-- Full Outer Join
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname
	where e.id is null or c.id is null;

SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o 
   ON o.product_id = p.product_id
  and order_id = 100
ORDER BY
    order_id;

-- CROSS JOIN
SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity
FROM
    production.products
CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;

-- Matching all staff with all store
select
	s.staff_id,
	s.first_name + ' ' + s.last_name as FullName,
	st.store_id,
	st.store_name as StoreName
from
	sales.staffs as s
cross join
	sales.stores st;

-- all possible order and customers
-- sales.orders
-- sales.customers

-- Self Join
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

-- Orders with similar dates
---- Find the orders placed on the same date
-- table: sales.orders








