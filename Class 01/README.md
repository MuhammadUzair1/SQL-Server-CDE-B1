# SQL Server Introduction

## Overview
This document provides an introduction to SQL Server and instructions on how to install it on your system along with SQL Server Management Studio (SSMS).

## Installation Instructions

### Step 1: Download SQL Server
1. Visit the [SQL Server Downloads](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) page.
2. Choose the appropriate edition for your needs (e.g., Developer, Express).
3. Download the installer.

### Step 2: Install SQL Server
1. Run the downloaded installer.
2. Follow the on-screen instructions to complete the installation.
3. Choose the default instance or name your instance as needed.
4. Configure the server as per your requirements (e.g., mixed mode authentication).

### Step 3: Download SQL Server Management Studio (SSMS)
1. Visit the [SSMS Download](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) page.
2. Download the latest version of SSMS.

### Step 4: Install SSMS
1. Run the downloaded SSMS installer.
2. Follow the on-screen instructions to complete the installation.

## Using SQL Server

To use SQL Server, there are three files stored in this folder. Follow these steps:

1. **First, run the `drop` script**: This script will drop any existing databases or objects that need to be reset.
2. **Next, run the `create` script**: This script will create the necessary databases and objects.
3. **Finally, run the `populate` script**: This script will populate the databases with initial data.

Make sure to execute these scripts in the correct order to ensure proper setup of your SQL Server environment.

## Conclusion
You have now installed SQL Server and SSMS on your system and are ready to start using SQL Server for your data engineering tasks. Happy coding!
Before executing these three files, execute the following two commands to create a database named `BikeStores` and then use it:

```sql
CREATE DATABASE BikeStores;
GO

USE BikeStores;
GO
```

Then, follow the steps below to set up your database:

1. **First, run the `drop` script**: This script will drop any existing databases or objects that need to be reset.
2. **Next, run the `create` script**: This script will create the necessary databases and objects.
3. **Finally, run the `load` script**: This script will populate the databases with initial data.

Executing these scripts in the correct order will create the whole database in SQL Server.