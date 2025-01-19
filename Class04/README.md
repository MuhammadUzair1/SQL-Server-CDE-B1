# SQL Tutorial - Class 04

## Overview
In this class, we explored various SQL concepts and queries using the `BikeStores` database. The focus was on data aggregation, grouping, joining tables, and set operations. Below is a detailed explanation of the concepts and queries covered in this class.

## Concepts and Queries

### 1. Aggregation and Grouping
We learned how to use aggregate functions like `SUM`, `COUNT`, `MAX`, and `MIN` along with the `GROUP BY` clause to summarize data.

```sql
USE BikeStores;

SELECT 
    model_year, SUM(list_price)
FROM
    production.products
GROUP BY
    model_year;
```

### 2. Filtering and Ordering
We used the `WHERE` clause to filter data and `ORDER BY` to sort the results.

```sql
SELECT
    customer_id,
    MONTH(order_date) AS order_month
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    MONTH(order_date)
ORDER BY
    customer_id;
```

### 3. Joining Tables
We joined multiple tables to combine data from different sources.

```sql
SELECT
    model_year, MAX(discount) AS Max_Discount, MIN(discount) AS Min_Discount
FROM
    production.products p
JOIN
    sales.order_items o ON p.product_id = o.product_id 
GROUP BY
    model_year;
```

### 4. Subqueries and Temporary Tables
We created temporary tables and used subqueries to simplify complex queries.

```sql
SELECT
    order_id,
    SUM(quantity * list_price * (1 - discount)) AS net_value
INTO sales.dump
FROM
    sales.order_items
GROUP BY
    order_id
HAVING
    SUM(quantity * list_price * (1 - discount)) > 20000
ORDER BY
    net_value;
```

### 5. Set Operations
We explored set operations like `UNION`, `UNION ALL`, `INTERSECT`, and `EXCEPT` to combine results from multiple queries.

```sql
-- UNION
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

-- INTERSECT
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

-- EXCEPT
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
```

### 6. Advanced Grouping
We used `CUBE` and `ROLLUP` to perform advanced grouping operations.

```sql
-- CUBE
SELECT
    brand,
    category,
    SUM(sales) AS sales
FROM
    sales.sales_summary
GROUP BY
    CUBE(brand, category);

-- ROLLUP
SELECT
    brand,
    category,
    SUM(sales) AS sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP(brand, category);
```

## Benefits of This Class
- **Data Summarization**: Learn to summarize large datasets using aggregate functions.
- **Data Filtering**: Understand how to filter and sort data effectively.
- **Table Joins**: Gain skills in combining data from multiple tables.
- **Set Operations**: Master set operations to handle complex queries.
- **Advanced Grouping**: Perform advanced data grouping for comprehensive analysis.

By mastering these concepts, you can efficiently manage and analyze data in SQL, making you a more proficient data engineer.
