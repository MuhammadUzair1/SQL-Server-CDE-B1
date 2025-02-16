USE BikeStores;

SELECT order_id, customer_id, order_status, order_date
from sales.orders
where customer_id in (
select customer_id from sales.customers 
where city = 'New York'
)
order by order_date desc;

SELECT product_name, list_price
FROM production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;

select order_id, order_date,
(
	select max(list_price)
	from sales.order_items i
	where i.order_id = o.order_id
) as max_list_price
from sales.orders o
order  by order_date desc;

select product_id, 
product_name,
(
select category_name 
from production.categories c
where c.category_id = p.category_id
) as category_name
from production.products p
where 
category_id in (
select category_id 
from production.categories
where category_name = 'Mountain Bikes'
or category_name = 'Road Bikes'
);
select 
product_name,
list_price
from
production.products
where
list_price >= Any (
select
avg(list_price)
from
production.products
group by
brand_id
)

SELECT 
   AVG(order_count) average_order_count_by_staff
FROM
(
    SELECT 
	staff_id, 
        COUNT(order_id) order_count
    FROM 
	sales.orders
    GROUP BY 
	staff_id 
) t;

SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    EXISTS (SELECT NULL)
ORDER BY
    first_name,
    last_name;

	SELECT
    AVG (list_price) avg_list_price
FROM
    production.products
GROUP BY
    brand_id
ORDER BY
    avg_list_price;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > ALL (
        SELECT
            AVG (list_price) avg_list_price
        FROM
            production.products
        GROUP BY
            brand_id
    )
ORDER BY
    list_price;

-- UNION 
SELECT first_name,last_name
FROM
    sales.staffs
UNION ALL
SELECT first_name, last_name
FROM
    sales.customers;

-- EXCEPT
SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items;

-- INTERSECT
SELECT
    product_id
FROM
    production.products
INTERSECT
SELECT
    product_id
FROM
    sales.order_items;

