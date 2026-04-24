-- ============================================================
-- Edison Store: Retail Sales Analysis
-- SQL Business Intelligence Project
-- Tool: MySQL
-- Author: Adebisi Farouk
-- Period: 2022 – 2023
-- ============================================================


-- ============================================================
-- CONNECTION LAYER
-- ============================================================

-- Python connection snippet (run before executing this file):
--
--   import mysql.connector
--
--   conn = mysql.connector.connect(
--       host="localhost",
--       user="root",
--       password="****",
--       database="edison_retail"
--   )
--
--   cursor = conn.cursor()
--   cursor.execute("SELECT DATABASE();")
--
--   for row in cursor:
--       print(row)
--
-- Connection string: mysql://root:****@localhost:3306/edison_retail
-- Protocol: TCP/IP · Port: 3306


-- ============================================================
-- DATABASE CONFIGURATION
-- ============================================================

CREATE DATABASE IF NOT EXISTS edison_retail;
USE edison_retail;

SELECT DATABASE(), VERSION(), USER(), NOW();


-- ============================================================
-- TABLE SCHEMA
-- ============================================================

CREATE TABLE retail_sales (
    transactions_id  INT PRIMARY KEY,
    sale_date        DATE,
    sale_time        TIME,
    customer_id      INT,
    gender           VARCHAR(10),
    age              INT,
    category         VARCHAR(50),
    quantity         INT,
    price_per_unit   DECIMAL(10, 2),
    cogs             DECIMAL(10, 2),
    total_sale       DECIMAL(10, 2)
);


-- ============================================================
-- DATA QUALITY CHECK
-- ============================================================

-- Check for NULL values across key columns
SELECT *
FROM retail_sales
WHERE
    transactions_id IS NULL OR
    sale_date       IS NULL OR
    sale_time       IS NULL OR
    customer_id     IS NULL OR
    gender          IS NULL OR
    age             IS NULL OR
    category        IS NULL OR
    quantity        IS NULL OR
    price_per_unit  IS NULL OR
    cogs            IS NULL OR
    total_sale      IS NULL;

-- Check total record count
SELECT COUNT(*) AS total_records
FROM retail_sales;


-- ============================================================
-- Q1: Sales for a Specific Date
-- Goal: Retrieve all transaction records made on 2022-11-05
-- Business Value: Daily transaction auditing
-- ============================================================

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


-- ============================================================
-- Q2: High-Quantity Clothing Sales
-- Goal: Retrieve Clothing transactions with quantity >= 4
--       placed in November 2022
-- Business Value: Seasonal demand & stock management
-- ============================================================

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity >= 4;


-- ============================================================
-- Q3: Net Sales by Category
-- Goal: Calculate total revenue and total orders per category
-- Business Value: Category performance ranking
-- ============================================================

SELECT 
    category,
    SUM(total_sale)  AS net_sale,
    COUNT(*)         AS total_orders
FROM retail_sales
GROUP BY 1;


-- ============================================================
-- Q4: Average Age in Beauty Category
-- Goal: Find the average age of Beauty category customers
-- Business Value: Demographic targeting for marketing
-- ============================================================

SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';


-- ============================================================
-- Q5: High-Value Transactions
-- Goal: List all transactions where total_sale > 1000
-- Business Value: High-value transaction identification
-- ============================================================

SELECT *
FROM retail_sales
WHERE total_sale > 1000;


-- ============================================================
-- Q6: Transaction Volume by Gender & Category
-- Goal: Count transactions broken down by category and gender
-- Business Value: Gender-based purchasing behaviour
-- ============================================================

SELECT 
    category,
    gender,
    COUNT(DISTINCT transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;


-- ============================================================
-- Q7: Best Selling Month per Year
-- Goal: Identify the month with the highest average sales
--       value for each year
-- Business Value: Seasonal trend & promotional planning
-- ============================================================

SELECT year, month, avg_sale
FROM (
    SELECT 
        YEAR(sale_date)              AS year,
        MONTH(sale_date)             AS month,
        ROUND(AVG(total_sale), 2)    AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        )                            AS rnk
    FROM retail_sales
    GROUP BY 1, 2
) AS ranked
WHERE rnk = 1;


-- ============================================================
-- Q8: Top 5 Customers by Revenue
-- Goal: Identify top 5 customers by lifetime total spend
-- Business Value: VIP customer identification for retention
-- ============================================================

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- ============================================================
-- Q9: Unique Customers per Category
-- Goal: Count distinct customers per product category
-- Business Value: Category reach & audience segmentation
-- ============================================================

SELECT 
    COUNT(DISTINCT customer_id) AS customer_count,
    category
FROM retail_sales
GROUP BY 2;


-- ============================================================
-- Q10: Order Volume by Time Shift
-- Goal: Segment all sales into Morning / Afternoon / Evening
--       to identify peak trading hours
-- Business Value: Staffing and operational planning
-- ============================================================

WITH Hourly_Sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12              THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE                                        'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM Hourly_Sale
GROUP BY shift;


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
