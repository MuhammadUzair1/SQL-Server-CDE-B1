# SQL Joins: Overview and Practice Guide

This README file explains the SQL file containing various types of SQL joins, their implementation, and practice scenarios. The SQL examples demonstrate how to use joins to combine data from multiple tables in a relational database.

---

## Overview of SQL Joins

SQL JOIN operations are used to combine rows from two or more tables based on a related column. This script covers:

- **Inner Join**: Retrieves records with matching values in both tables.
- **Left Join**: Retrieves all records from the left table and matched records from the right table.
- **Right Join**: Retrieves all records from the right table and matched records from the left table.
- **Full Outer Join**: Retrieves all records when there is a match in either table.
- **Cross Join**: Combines each row from one table with every row in another table.
- **Self Join**: Joins a table with itself to find relationships within the same dataset.

A visual representation of SQL Joins is provided below:

![SQL Joins](img/SQL_Joins.jpg)

---

## Script Description

The SQL script includes the following sections:

1. **Table Creation and Data Insertion**:
    - Two tables (`hr.candidates` and `hr.employees`) are created and populated with sample data.
    - These tables are used to demonstrate various JOIN operations.

2. **Join Examples**:
    - **Inner Join**: Identifies candidates who are also employees.
    - **Left Join**: Retrieves all candidates and matches them with employees.
    - **Right Join**: Retrieves all employees and matches them with candidates.
    - **Full Outer Join**: Lists all candidates and employees, including unmatched records.
    - **Cross Join**: Combines rows from the `production.products` and `sales.stores` tables.
    - **Self Join**: Demonstrates hierarchical relationships, such as employees and their managers.

3. **Practice Scenarios**:
    - Several case-based SQL join questions are provided to encourage hands-on learning and deeper understanding.

---

## Schema Used

This script is built on the **BikeStores** database schema. The schema includes the following key tables:

### Production Schema:
- **Categories**: Defines product categories.
- **Brands**: Stores brand information.
- **Products**: Lists product details.
- **Stocks**: Tracks product stock levels at stores.

### Sales Schema:
- **Customers**: Contains customer information.
- **Stores**: Stores sales location details.
- **Staffs**: Maintains employee data, including hierarchical relationships (managers and staff).
- **Orders**: Records sales orders.
- **Order Items**: Tracks products sold in each order.

---

## Practice Questions

### Case Scenarios

1. **Inner Join Practice**:
    - Find the names of customers who placed orders, including the order details.
    - Tables: `sales.customers`, `sales.orders`.

    ```sql
    SELECT c.first_name, c.last_name, o.order_id, o.order_date
    FROM sales.customers c
    INNER JOIN sales.orders o ON c.customer_id = o.customer_id;
    ```

2. **Left Join Practice**:
    - List all products and their associated orders. Include products that have never been ordered.
    - Tables: `production.products`, `sales.order_items`.

3. **Right Join Practice**:
    - Identify all employees and their associated managers. Include employees without managers.
    - Tables: `sales.staffs` (self-join).

4. **Full Outer Join Practice**:
    - Compare the stock levels at all stores. Include stores without stock and stock items without a store.
    - Tables: `production.stocks`, `sales.stores`.

5. **Cross Join Practice**:
    - Generate all possible combinations of customers and products for marketing purposes.
    - Tables: `sales.customers`, `production.products`.

---

### Additional Questions

1. Identify the total number of orders placed by each customer.
    - Tables: `sales.customers`, `sales.orders`.

2. List all stores and the total number of staff at each store.
    - Tables: `sales.stores`, `sales.staffs`.

3. Find products that have been ordered more than 10 times in total.
    - Tables: `production.products`, `sales.order_items`.

4. Retrieve all orders placed on the same date using a self-join.
    - Tables: `sales.orders`.

5. Match all staff members with all stores using a cross join.
    - Tables: `sales.staffs`, `sales.stores`.

---

Happy Learning! 

