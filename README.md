SQL Data Warehouse Project
📌 Project Overview

This project demonstrates the design and implementation of a modern SQL Data Warehouse using SQL Server. The warehouse consolidates data from multiple source systems, transforms raw data into analytical models, and enables business reporting and decision-making.

The project follows industry-standard Data Warehousing concepts including:

Data Extraction
Data Cleaning
Data Transformation
Data Integration
Dimensional Modeling
Business Analytics

🎯 Project Objectives
The main objectives of this project are:

Build a centralized data warehouse.
Integrate data from multiple source systems.
Improve data quality through cleansing and validation.
Create analytical data models for reporting.
Generate business insights using SQL queries.
🏗️ Architecture
Source Systems
     │
     ▼
Staging Layer
     │
     ▼
Data Cleaning & Transformation
     │
     ▼
Data Warehouse
     │
     ▼
Analytics & Reporting
📂 Project Structure
SQL-Data-Warehouse-Project/
│
├── datasets/
│   ├── source_data/
│   └── cleaned_data/
│
├── scripts/
│   ├── create_database.sql
│   ├── staging_tables.sql
│   ├── data_cleaning.sql
│   ├── warehouse_tables.sql
│   └── analytics_queries.sql
│
├── documentation/
│   └── data_dictionary.md
│
└── README.md
🗄️ Data Sources

The project uses data collected from:

Source 1: ERP System

Contains:

Customer Information
Product Information
Sales Transactions
Source 2: CRM System

Contains:

Customer Details
Customer Interactions
Marketing Information
🔄 ETL Process
Extract

Data is imported from CSV files into staging tables.

Transform

Data quality issues handled:

Duplicate records removed
Missing values handled
Invalid records corrected
Standardized data formats
Load

Cleaned data is loaded into warehouse tables designed for analytics.

📊 Data Model

The warehouse follows a Star Schema design.

Fact Table
Fact_Sales
Column	Description
Sale_ID	Unique Sale Identifier
Customer_ID	Customer Key
Product_ID	Product Key
Date_ID	Date Key
Quantity	Quantity Sold
Revenue	Total Revenue
Dimension Tables
Dim_Customer
Customer_ID
Customer_Name
City
Country
Dim_Product
Product_ID
Product_Name
Category
Brand
Dim_Date
Date_ID
Date
Month
Quarter
Year
📈 Business Analysis

The warehouse supports analysis such as:

Customer Analysis
Top Customers
Customer Segmentation
Customer Purchase Trends
Product Analysis
Best Selling Products
Category Performance
Revenue by Product
Sales Analysis
Monthly Sales Trends
Quarterly Revenue Growth
Yearly Performance
🛠️ Technologies Used
SQL Server
T-SQL
SQL Server Management Studio (SSMS)
CSV Files
Data Warehousing Concepts
📋 Sample SQL Queries
Top 10 Customers by Revenue
SELECT TOP 10
    Customer_Name,
    SUM(Revenue) AS Total_Revenue
FROM Fact_Sales fs
JOIN Dim_Customer dc
ON fs.Customer_ID = dc.Customer_ID
GROUP BY Customer_Name
ORDER BY Total_Revenue DESC;
Monthly Sales Trend
SELECT
    Year,
    Month,
    SUM(Revenue) AS Revenue
FROM Fact_Sales fs
JOIN Dim_Date dd
ON fs.Date_ID = dd.Date_ID
GROUP BY Year, Month
ORDER BY Year, Month;
🚀 Key Learnings

Through this project, I learned:

Data Warehouse Design
Star Schema Modeling
ETL Development
SQL Query Optimization
Data Cleaning Techniques
Business Analytics
👨‍💻 Author

Aman Sharma

Aspiring Data Analyst | SQL | Excel | Power BI | Python

📜 License

This project is licensed under the MIT License.
