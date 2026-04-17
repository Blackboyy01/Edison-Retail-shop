# Edison-Retail-shop
# 🛍️ Retail Sales Analysis — SQL Business Intelligence Project

> A SQL-based analytics project delivering actionable insights from retail transaction data to support sales strategy, customer segmentation, and operational decision-making.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Data_Analysis-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window_Functions-CTEs-003B57?style=for-the-badge)
![Data Cleaning](https://img.shields.io/badge/Data_Cleaning-Validation-003B57?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## 📌 Problem Statement

A retail business with a diverse product catalogue spanning multiple categories — including Clothing and Beauty — needed a structured way to understand its sales performance, customer behaviour, and operational patterns. The company held a rich dataset of point-of-sale transactions but lacked the analytical framework to extract meaningful business insights from it.

The core business challenge was: **how can transaction-level data be transformed into intelligence that drives smarter decisions around product strategy, customer targeting, and staffing?**

Without clear visibility into who is buying, what is selling, when peak activity occurs, and which customers drive the most revenue, the business risked making strategic decisions on intuition alone.

---

## 🎯 Project Objectives

1. **Clean and validate** the transaction dataset to ensure analytical integrity before drawing conclusions.
2. **Establish baseline metrics** — total sales volume, unique customer count, and category breadth.
3. **Analyse category performance** to identify which product lines generate the most revenue and order volume.
4. **Profile customers** by demographics (age, gender) and purchasing behaviour across categories.
5. **Uncover temporal trends** — identifying peak sales months per year and busiest trading shifts by time of day.
6. **Rank top customers** by total spend to support loyalty and retention strategies.
7. **Segment transactions by shift** to provide operational insight for staffing and inventory planning.

---

## 🗂️ Project Overview

This project was delivered as a freelance engagement, simulating a real-world retail analytics brief. Using a single relational table of retail transaction records, a series of structured SQL queries were developed to answer 10 targeted business questions — covering data quality assessment, sales analysis, customer intelligence, and operational insights.

The analysis was designed to be immediately actionable: each query maps to a specific business decision, from understanding which categories to prioritise to knowing when the store is busiest.

### Database Schema

| Column | Type | Description |
|---|---|---|
| `transaction_id` | INT (PK) | Unique transaction identifier |
| `sale_date` | DATE | Date of transaction |
| `sale_time` | TIME | Time of transaction |
| `customer_id` | INT | Customer identifier |
| `gender` | VARCHAR | Customer gender |
| `age` | INT | Customer age |
| `category` | VARCHAR | Product category |
| `quantity` | INT | Units sold |
| `price_per_unit` | FLOAT | Unit price |
| `cogs` | FLOAT | Cost of goods sold |
| `total_sale` | FLOAT | Total transaction value |

### Business Questions Answered

| # | Question | Business Value |
|---|---|---|
| 1 | All sales on a specific date | Daily transaction auditing |
| 2 | Clothing transactions with quantity ≥ 4 in Nov 2022 | Seasonal demand & stock management |
| 3 | Total sales and order count per category | Category performance ranking |
| 4 | Average customer age in the Beauty category | Demographic targeting for marketing |
| 5 | Transactions where total sale exceeds 1,000 | High-value transaction identification |
| 6 | Transaction count by gender within each category | Gender-based purchasing behaviour |
| 7 | Best-selling month per year by average sale | Seasonal trend & promotional planning |
| 8 | Top 5 customers by total spend | VIP customer identification for retention |
| 9 | Unique customers per category | Category reach & audience segmentation |
| 10 | Order volume by shift (Morning / Afternoon / Evening) | Staffing and operational planning |

---

## 💡 Key Insights Delivered

- **Category Performance:** Identified which product categories generate the highest net revenue and order frequency, enabling focused inventory and marketing investment.
- **Seasonal Peaks:** Pinpointed the best-performing month in each year by average sale value — informing when to run promotions or increase stock.
- **Customer Demographics:** Revealed the average age of Beauty category shoppers, providing a foundation for targeted campaigns.
- **VIP Customers:** Surfaced the top 5 highest-spending customers, enabling the business to design loyalty or retention programmes.
- **Shift Analysis:** Quantified order volumes by time of day, giving management clear data to optimise staffing schedules and in-store experience.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Database creation, data storage, and query execution |
| **SQL (DDL & DML)** | Schema design, data cleaning, and analytical queries |
| **CASE Statements** | Data quality flagging and shift segmentation |
| **Window Functions** | `RANK()` for identifying best-selling months per year |
| **CTEs** | Structuring the shift analysis query cleanly |
| **Aggregate Functions** | `SUM()`, `COUNT()`, `AVG()`, `ROUND()` for business metrics |
| **Date & Time Functions** | `YEAR()`, `MONTH()`, `HOUR()`, `DATE_FORMAT()` for temporal analysis |

---

## 📁 Repository Structure

```
retail-sales-analysis/
│
├── SQL_project_1.sql       # Full SQL script (schema + cleaning + analysis queries)
└── README.md               # Project documentation
```

---

## 🚀 How to Run

1. Open your MySQL client (e.g., MySQL Workbench, DBeaver, or CLI).
2. Run the `SQL_project_1.sql` script — it will create the `retail_sales` table.
3. Import your retail transaction data (CSV) into the `retail_sales` table.
4. Execute individual queries to explore each business question.

---

## 👤 Author

**[Your Name]**
Business/Sales Analyst | SQL · Data Analysis · Retail Intelligence
[LinkedIn](#) · [GitHub](#)
