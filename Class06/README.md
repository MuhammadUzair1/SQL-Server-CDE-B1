# SQL Server Class 06 - Study Guide

Welcome to the sixth class of our SQL Server tutorial series. In this class, we will cover several important topics that are essential for working with SQL Server. This guide will help you understand and practice the concepts discussed in the class.

## Topics Covered

1. **Common Table Expressions (CTE)**
2. **Temporary Tables**
3. **SQL Statements: SELECT, UPDATE, INSERT, DELETE, MERGE**

### Common Table Expressions (CTE)

A Common Table Expression (CTE) is a temporary result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. CTEs are defined using the `WITH` keyword.

**Syntax:**
```sql
WITH expression_name [(column_name [,...])]
AS (CTE_definition)
SQL_statement;
```

**Example: Sales by each staff member in 2018**
```sql
WITH cte_sales_amount (sales, Sale_Amount, year) AS (
    SELECT 
        first_name + last_name AS Full_Name,
        SUM(quantity * list_price * (1 - discount)) AS Sale_Amount,
        YEAR(order_date)
    FROM 
        sales.orders O
    JOIN
        sales.staffs S ON S.staff_id = O.staff_id
    JOIN
        sales.order_items OI ON O.order_id = OI.order_id
    GROUP BY 
        first_name + last_name, YEAR(order_date)
)
SELECT * FROM cte_sales_amount;
```

### Temporary Tables

Temporary tables are used to store temporary data. They are created using the `CREATE TABLE` statement and are automatically dropped when the session ends.

**Example:**
```sql
CREATE TABLE #TempTable (
    id INT,
    name VARCHAR(50)
);
```

### SQL Statements

#### SELECT
The `SELECT` statement is used to query data from a database.

**Example:**
```sql
SELECT * FROM sales.orders;
```

#### INSERT
The `INSERT` statement is used to add new rows to a table.

**Example:**
```sql
INSERT INTO sales.taxes (state, state_tax_rate, avg_local_tax_rate, max_local_tax_rate)
VALUES ('Alabama', 0.04, 0.05, 0.07);
```

#### UPDATE
The `UPDATE` statement is used to modify existing rows in a table.

**Example:**
```sql
UPDATE sales.taxes
SET max_local_tax_rate += 0.02, avg_local_tax_rate += 0.01
WHERE max_local_tax_rate = 0.01;
```

#### DELETE
The `DELETE` statement is used to remove rows from a table.

**Example:**
```sql
DELETE TOP (10) FROM sales.taxes;
```

#### MERGE
The `MERGE` statement is used to perform insert, update, or delete operations in a single statement.

**Example:**
```sql
MERGE sales.category t 
USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED THEN 
    UPDATE SET t.category_name = s.category_name, t.amount = s.amount
WHEN NOT MATCHED BY TARGET THEN 
    INSERT (category_id, category_name, amount) VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE THEN 
    DELETE;
```

### Practice Queries

1. **Average number of sale orders in 2018**
    ```sql
    WITH cte_order_count AS (
        SELECT staff_id, COUNT(DISTINCT order_id) AS order_count
        FROM sales.orders
        WHERE YEAR(order_date) = 2018
        GROUP BY staff_id
    )
    SELECT AVG(order_count) AS Average_orders FROM cte_order_count;
    ```

2. **Recursive CTE**
    ```sql
    WITH cte_numbers(n, weekday) AS (
        SELECT 0, DATENAME(DW, 0)
        UNION ALL
        SELECT n + 1, DATENAME(DW, n + 1)
        FROM cte_numbers
        WHERE n < 6
    )
    SELECT weekday FROM cte_numbers;
    ```

3. **PIVOT Example**
    ```sql
    SELECT * FROM (
        SELECT category_name, product_id
        FROM production.products p
        INNER JOIN production.categories c ON c.category_id = p.category_id
    ) t 
    PIVOT (
        COUNT(product_id) FOR category_name IN (
            [Children Bicycles], 
            [Comfort Bicycles], 
            [Cruisers Bicycles], 
            [Cyclocross Bicycles], 
            [Electric Bikes], 
            [Mountain Bikes], 
            [Road Bikes]
        )
    ) AS pivot_table;
    ```

### Data Definition Language (DDL)

#### CREATE DATABASE
```sql
CREATE DATABASE TestDB;
```

#### CREATE TABLE
```sql
CREATE TABLE sales.taxes (
    tax_id INT PRIMARY KEY IDENTITY (1, 1),
    state VARCHAR (50) NOT NULL UNIQUE,
    state_tax_rate DEC (3, 2),
    avg_local_tax_rate DEC (3, 2),
    combined_rate AS state_tax_rate + avg_local_tax_rate,
    max_local_tax_rate DEC (3, 2),
    updated_at DATETIME
);
```

#### ALTER SCHEMA
```sql
ALTER SCHEMA customer_services TRANSFER OBJECT::dbo.offices;
```

#### DROP DATABASE
```sql
DROP DATABASE IF EXISTS SampleDb;
```

By following this guide and practicing the provided examples, you will gain a solid understanding of the topics covered in the sixth class of our SQL Server tutorial series. Happy learning!