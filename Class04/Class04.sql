USE BikeStores;

SELECT 
	model_year, sum(list_price)
FROM
	production.products
GROUP BY
	model_year;

SELECT
    customer_id,
    Month (order_date) order_month
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    MONTH (order_date)
ORDER BY
    customer_id;

SELECT
    customer_id,
    YEAR (order_date) order_year,
    COUNT (order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id; 

SELECT
	model_year, MAX(discount) as Max_Discount, MIN(discount) as Min_Discount
FROM
	production.products p
JOIN
	sales.order_items o ON p.product_id = o.product_id 
GROUP BY
	model_year;

SELECT * FROM production.products;
SELECT * FROM sales.order_items;

-- Find the number of unique products orders by a customer at a sametime and order total price.
select order_id, COUNT(DISTINCT(product_id)) as Unique_Products, sum(list_price) as Total_Price
FROM sales.order_items 
GROUP BY order_id
HAVING sum(list_price) > 5000;

SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
	into sales.dump
FROM
    sales.order_items
GROUP BY
    order_id
HAVING
    SUM (
        quantity * list_price * (1 - discount)
    ) > 20000
ORDER BY
    net_value;

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    CUBE(brand, category);

--ROLL UP
SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP(brand, category);

-------UNION--------
SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION
SELECT
    first_name,
    last_name
FROM
    sales.customers;

-------UNION ALL--------
SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION ALL
SELECT
    first_name,
    last_name
FROM
    sales.customers;

select first_name, last_name
from (
SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION All
SELECT
    first_name,
    last_name
FROM
    sales.customers
	) as combined
group by first_name ,last_name
having count(first_name) > 1;

-------INTERSECT--------
SELECT
    city
FROM
    sales.customers
INTERSECT
SELECT
    city
FROM
    sales.stores
ORDER BY
    city;

-------EXCEPT--------
SELECT
    city
FROM
    sales.customers
EXCEPT
SELECT
    city
FROM
    sales.stores
ORDER BY
    city;



