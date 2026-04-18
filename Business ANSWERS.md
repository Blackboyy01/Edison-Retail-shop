# 🛒 Edison Store: Retail Sales Analysis

> A comprehensive SQL-based analysis of retail transactions to uncover consumer behavior, sales performance, and operational patterns across the Edison Store dataset.

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Database Schema](#database-schema)
3. [Business Questions & SQL Queries](#business-questions--sql-queries)
   - [Q1: Sales for a Specific Date](#q1-sales-for-a-specific-date)
   - [Q2: High-Quantity Clothing Sales](#q2-high-quantity-clothing-sales)
   - [Q3: Net Sales by Category](#q3-net-sales-by-category)
   - [Q4: Average Age in Beauty Category](#q4-average-age-in-beauty-category)
   - [Q5: High-Value Transactions](#q5-high-value-transactions)
   - [Q6: Transaction Volume by Gender & Category](#q6-transaction-volume-by-gender--category)
   - [Q7: Best Selling Month per Year](#q7-best-selling-month-per-year)
   - [Q8: Top 5 Customers by Revenue](#q8-top-5-customers-by-revenue)
   - [Q9: Unique Customers per Category](#q9-unique-customers-per-category)
   - [Q10: Order Volume by Time Shift](#q10-order-volume-by-time-shift)
4. [Key Insights](#key-insights)

---

## Project Overview

| Detail | Info |
|---|---|
| **Store** | Edison Store |
| **Dataset** | Retail Transactions |
| **Period Covered** | 2022 – 2023 |
| **Total Categories** | Beauty, Clothing, Electronics |
| **Tool Used** | MySQL |
| **Total Orders Analyzed** | ~1,987 |

---

## Database Schema

```sql
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
```

---

## Business Questions & SQL Queries

---

### Q1: Sales for a Specific Date

**Goal:** Retrieve all transaction records made on `2022-11-05`.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**Results (sample):**

| transactions_id | sale_date  | sale_time | customer_id | gender | age | category    | quantity | price_per_unit | cogs   | total_sale |
|----------------|------------|-----------|-------------|--------|-----|-------------|----------|----------------|--------|------------|
| 180            | 2022-11-05 | 10:47:00  | 117         | Male   | 41  | Clothing    | 3        | 300.00         | 129.00 | 900.00     |
| 214            | 2022-11-05 | 16:31:00  | 53          | Male   | 20  | Beauty      | 2        | 30.00          | 8.10   | 60.00      |
| 240            | 2022-11-05 | 11:49:00  | 95          | Female | 23  | Beauty      | 1        | 300.00         | 123.00 | 300.00     |
| 856            | 2022-11-05 | 17:43:00  | 102         | Male   | 54  | Electronics | 4        | 30.00          | 9.30   | 120.00     |
| 943            | 2022-11-05 | 19:29:00  | 90          | Female | 57  | Clothing    | 4        | 300.00         | 318.00 | 1,200.00   |

---

### Q2: High-Quantity Clothing Sales

**Goal:** Retrieve `Clothing` transactions with `quantity >= 4` placed in November 2022.

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity >= 4;
```

**Results (sample):**

| transactions_id | sale_date  | customer_id | category | quantity | total_sale |
|----------------|------------|-------------|----------|----------|------------|
| 64             | 2022-11-15 | 7           | Clothing | 4        | 100.00     |
| 146            | 2022-11-10 | 74          | Clothing | 4        | 200.00     |
| 547            | 2022-11-14 | 3           | Clothing | 4        | 2,000.00   |

---

### Q3: Net Sales by Category

**Goal:** Calculate total revenue and total number of orders for each product category.

```sql
SELECT 
    category,
    SUM(total_sale)  AS net_sale,
    COUNT(*)         AS total_orders
FROM retail_sales
GROUP BY 1;
```

**Results:**

| category    | net_sale     | total_orders |
|-------------|--------------|--------------|
| Beauty      | 286,790.00   | 611          |
| Clothing    | 309,995.00   | 698          |
| Electronics | 311,445.00   | 678          |

> 💡 **Electronics** leads in net revenue, while **Clothing** records the highest order volume.

---

### Q4: Average Age in Beauty Category

**Goal:** Find the average age of customers who purchased from the `Beauty` category.

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

**Result:**

| avg_age |
|---------|
| 40.42   |

> 💡 The average Beauty shopper is approximately **40 years old**, indicating a mature customer segment.

---

### Q5: High-Value Transactions

**Goal:** List all transactions where `total_sale > 1000`.

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

**Results (sample):**

| transactions_id | sale_date  | customer_id | category    | total_sale |
|----------------|------------|-------------|-------------|------------|
| 13             | 2023-02-08 | 106         | Electronics | 1,500.00   |
| 15             | 2022-07-01 | 75          | Electronics | 2,000.00   |
| 16             | 2022-06-25 | 82          | Clothing    | 1,500.00   |

---

### Q6: Transaction Volume by Gender & Category

**Goal:** Count distinct transactions broken down by `category` and `gender`.

```sql
SELECT 
    category,
    gender,
    COUNT(DISTINCT transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;
```

**Results:**

| category    | gender | total_transactions |
|-------------|--------|--------------------|
| Beauty      | Female | 330                |
| Beauty      | Male   | 281                |
| Clothing    | Female | 347                |
| Clothing    | Male   | 351                |
| Electronics | Female | 335                |
| Electronics | Male   | 343                |

> 💡 Gender distribution is relatively balanced across all three categories.

---

### Q7: Best Selling Month per Year

**Goal:** Identify the month with the highest average sales value for each year.

```sql
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
```

**Results:**

| year | month | avg_sale |
|------|-------|----------|
| 2022 | 7     | 541.34   |
| 2023 | 2     | 535.53   |

> 💡 **July 2022** and **February 2023** were the peak revenue months for their respective years.

---

### Q8: Top 5 Customers by Revenue

**Goal:** Identify the top 5 customers based on their lifetime total purchase value.

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

**Results:**

| customer_id | total_sales |
|-------------|-------------|
| 3           | 38,440.00   |
| 1           | 30,750.00   |
| 5           | 30,405.00   |
| 2           | 25,295.00   |
| 4           | 23,580.00   |

> 💡 **Customer #3** is the highest value customer with over **$38K** in lifetime spend.

---

### Q9: Unique Customers per Category

**Goal:** Count how many distinct customers purchased from each product category.

```sql
SELECT 
    COUNT(DISTINCT customer_id) AS customer_count,
    category
FROM retail_sales
GROUP BY 2;
```

**Results:**

| category    | customer_count |
|-------------|---------------|
| Beauty      | 141           |
| Clothing    | 149           |
| Electronics | 144           |

> 💡 **Clothing** attracts the widest unique customer base across all categories.

---

### Q10: Order Volume by Time Shift

**Goal:** Segment all sales into `Morning`, `Afternoon`, and `Evening` shifts to identify peak trading hours.

```sql
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
```

**Results:**

| shift     | total_orders |
|-----------|--------------|
| Evening   | 1,062        |
| Morning   | 548          |
| Afternoon | 377          |

> 💡 **Evening** is by far the busiest trading period, accounting for over **53%** of all orders.

---

## Key Insights

| # | Insight |
|---|---------|
| 1 | **Electronics** generates the highest net revenue at **$311,445**, narrowly ahead of Clothing. |
| 2 | **Evening hours** dominate order volume with **1,062 orders** — ideal window for promotions and flash sales. |
| 3 | The **Beauty** category skews toward customers aged ~40, suggesting targeted marketing opportunities. |
| 4 | **Customer #3** is the store's most valuable customer with **$38,440** in total lifetime spend. |
| 5 | **July 2022** and **February 2023** were peak revenue months — likely driven by seasonal demand. |
| 6 | Gender split across all categories is nearly **50/50**, indicating broad cross-gender appeal. |
| 7 | **Clothing** has the highest unique customer count (**149**), showing the widest market reach. |

---

*Analysis performed using MySQL on the Edison Store retail transactions dataset.*
