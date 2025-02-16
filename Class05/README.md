# SQL Tutorial Class 05

Welcome to Class 05 of our SQL Tutorial series. In this class, we covered various advanced SQL topics and queries. Below is a detailed guideline of what we learned, along with example queries.

## Topics Covered

1. **Subqueries**
2. **Aggregate Functions**
3. **Set Operations**
4. **Correlated Subqueries**

### 1. Subqueries

Subqueries are queries nested inside another query. They can be used in various clauses like `SELECT`, `FROM`, `WHERE`, etc.

#### Example 1: Subquery in `WHERE` Clause
```sql
USE BikeStores;

SELECT order_id, customer_id, order_status, order_date
FROM sales.orders
WHERE customer_id IN (
    SELECT customer_id 
    FROM sales.customers 
    WHERE city = 'New York'
)
ORDER BY order_date DESC;
```

#### Example 2: Subquery in `SELECT` Clause
```sql
SELECT order_id, order_date,
(
    SELECT MAX(list_price)
    FROM sales.order_items i
    WHERE i.order_id = o.order_id
) AS max_list_price
FROM sales.orders o
ORDER BY order_date DESC;
```

### 2. Aggregate Functions

Aggregate functions perform a calculation on a set of values and return a single value.

#### Example 1: Using `AVG` with `GROUP BY`
```sql
SELECT 
    AVG(order_count) AS average_order_count_by_staff
FROM (
    SELECT 
        staff_id, 
        COUNT(order_id) AS order_count
    FROM sales.orders
    GROUP BY staff_id 
) t;
```

#### Example 2: Using `MAX` with `GROUP BY`
```sql
SELECT
    product_name,
    list_price,
    category_id
FROM production.products p1
WHERE list_price IN (
    SELECT MAX(p2.list_price)
    FROM production.products p2
    WHERE p2.category_id = p1.category_id
    GROUP BY p2.category_id
)
ORDER BY category_id, product_name;
```

### 3. Set Operations

Set operations combine the results of two or more queries into a single result set.

#### Example 1: `UNION ALL`
```sql
SELECT first_name, last_name
FROM sales.staffs
UNION ALL
SELECT first_name, last_name
FROM sales.customers;
```

#### Example 2: `EXCEPT`
```sql
SELECT product_id
FROM production.products
EXCEPT
SELECT product_id
FROM sales.order_items;
```

#### Example 3: `INTERSECT`
```sql
SELECT product_id
FROM production.products
INTERSECT
SELECT product_id
FROM sales.order_items;
```

### 4. Correlated Subqueries

A correlated subquery is a subquery that uses values from the outer query.

#### Example: Correlated Subquery
```sql
SELECT product_id, 
       product_name,
       (
           SELECT category_name 
           FROM production.categories c
           WHERE c.category_id = p.category_id
       ) AS category_name
FROM production.products p
WHERE category_id IN (
    SELECT category_id 
    FROM production.categories
    WHERE category_name = 'Mountain Bikes'
    OR category_name = 'Road Bikes'
);
```

## Conclusion

In this class, we explored various advanced SQL topics, including subqueries, aggregate functions, set operations, and correlated subqueries. These concepts are essential for writing complex and efficient SQL queries. Practice these queries to solidify your understanding.

Happy querying!