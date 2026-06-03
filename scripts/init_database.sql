/*
=============================================================
Create Database and Schemas
=============================================================

Purpose:
This script creates a new database named 'DataWarehouse'.
If the database already exists, it will be dropped and recreated.

Schemas:
- bronze : Raw data layer
- silver : Cleaned and transformed data layer
- gold   : Business-ready analytical layer
=============================================================
*/

USE master;
GO

-- Drop database if it exists
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END
GO

-- Create database
CREATE DATABASE DataWarehouse;
GO

-- Use database
USE DataWarehouse;
GO

-- Create Bronze Schema
CREATE SCHEMA bronze;
GO

-- Create Silver Schema
CREATE SCHEMA silver;
GO

-- Create Gold Schema
CREATE SCHEMA gold;
GO

PRINT 'DataWarehouse and all schemas created successfully.';
GO
