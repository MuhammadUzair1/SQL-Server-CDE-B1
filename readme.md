# SQL Server Tutorials

Welcome to the **SQL Server Tutorials** repository! This comprehensive guide is designed to help you master SQL Server from the basics to advanced concepts. Whether you're a novice or a professional aiming to refine your skills, this course offers valuable insights and practical knowledge to become proficient in SQL Server as a Data Engineer or Software Engineer.

## About the Repository
This repository contains structured folders for each tutorial session, with SQL files and supplementary materials used in each class. Every module builds upon the previous one, ensuring a gradual yet robust learning experience.

---

## Database Used: BikeStores
We will use the **BikeStores** sample database, a well-structured dataset featuring tables for:

- **Production**: Categories, Brands, Products, and Stocks.
- **Sales**: Customers, Stores, Staffs, Orders, and Order Items.

The schema provides an excellent foundation for learning SQL operations, including data modeling, querying, and performance optimization.

> **Database Schema Reference**: ![BikeStores Database Schema](SQL-Server-BikeStore-Database.png)

---

## What You'll Learn
### **Module 1: SQL Server Installation Guide & Setup**
- Learn to install **SQL Server 2022 Developer Edition** and **SQL Server Management Studio (SSMS)**.
- Configure the environment for efficient development and querying.

### **Module 2: Data Modeling**
- Explore the principles of database design.
- Understand efficient data storage, retrieval, and optimization techniques.

### **Module 3: SQL Fundamentals with SQL Server**
- Write basic queries with `SELECT`, `WHERE`, and `ORDER BY`.
- Ensure data integrity with constraints.

### **Module 4: Data Definition and Manipulation**
- Create and alter database structures using DDL (Data Definition Language).
- Insert, update, and delete data using DML (Data Manipulation Language).

### **Module 5: Advanced Querying Techniques**
- Perform aggregations with `GROUP BY` and set operations like `UNION`, `INTERSECT`, and `EXCEPT`.
- Analyze multidimensional data using `CUBE` and `ROLLUP`.

### **Module 6: Joining Data**
- Master various join types, including `INNER`, `LEFT`, `RIGHT`, and `FULL OUTER` joins.
- Solve real-world data integration scenarios.

### **Module 7: Performance and Structure**
- Optimize query performance using indexes.
- Simplify data retrieval with views and subqueries.

### **Module 8: Advanced SQL Concepts**
- Use **Common Table Expressions (CTEs)** and window functions for complex queries.

### **Module 9: Encapsulating Logic**
- Write stored procedures to encapsulate reusable logic.
- Automate tasks using triggers.

---

## Learning Outcomes
By the end of this tutorial series, you will:

1. **Understand SQL Server Architecture**: Gain insights into the core components and functionality of SQL Server.
2. **Write Complex SQL Queries**: Solve practical problems using advanced SQL techniques.
3. **Design Efficient Databases**: Create normalized, optimized schemas for real-world applications.
4. **Enhance Query Performance**: Implement indexing strategies and query optimization techniques.
5. **Develop SQL-Based Applications**: Encapsulate logic using stored procedures, views, and triggers.

This knowledge will empower you to:
- Design and manage databases as a **Data Engineer**.
- Integrate and query data efficiently as a **Software Engineer**.
- Optimize and troubleshoot SQL Server performance.

---

## How to Use This Repository
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/sql-server-tutorials.git
   ```
2. Navigate to the relevant class folder to access SQL files and resources.
3. Follow the structured learning path from Module 1 to Module 9.
4. Practice the questions provided in each module to strengthen your understanding.

---

## Practice Questions
Each module includes case scenarios and exercises to apply the concepts taught. For example:

### Example Practice Question:
**Scenario**: Your company wants to find all customers who placed orders but didn't make any purchases.
- **Tables to Use**: `sales.customers`, `sales.orders`, `sales.order_items`.
- **Hint**: Use a `LEFT JOIN` to find customers with no matching order items.

---

Start your SQL Server journey today and take your data engineering or software engineering career to the next level!

