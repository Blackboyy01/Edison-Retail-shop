# Edison's Retail Sales Analysis — SQL Business Intelligence Project

> A SQL-based analytics project delivering actionable insights from retail transaction data to support sales strategy, customer segmentation, and operational decision-making.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Data_Analysis-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Window Functions](https://img.shields.io/badge/Window_Functions-CTEs-003B57?style=for-the-badge)
![Data Cleaning](https://img.shields.io/badge/Data_Cleaning-Validation-003B57?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Problem Statement](#problem-statement)
3. [Project Objectives](#project-objectives)
4. [Project Overview](#project-overview)
   - [Database Schema](#database-schema)
   - [Business Questions](#business-questions)
5. [Key Insights](#key-insights)
6. [Strategic Recommendations](#strategic-recommendations)
7. [Tools & Technologies](#tools--technologies)
8. [Author](#author)

---

## Executive Summary

Edison Store delivered solid performance across its three core categories between 2022 and 2023, processing nearly **1,987 transactions** worth approximately **$908,230** in total revenue. Electronics led on revenue at **$311,445**, while Clothing drove the highest order volume at **698 transactions** and the widest unique customer reach with **149 distinct buyers**.

The business shows a strong evening bias over **53%** of all orders occur after 5 PM while morning and afternoon periods remain significantly underutilised. Seasonally, **July 2022** (avg. $541/sale) and **February 2023** (avg. $536/sale) stood out as the highest-value months, likely reflecting recurring demand cycles worth capitalising on with targeted promotions.

Gender split is near-equal across all categories, suggesting broad market appeal. The Beauty segment, however, skews toward a mature customer base (avg. age ~40), presenting a clear opportunity for age-specific product positioning and marketing. At the customer level, a small group of VIP buyers drives outsized value **Customer #3** alone accounts for **$38,440** in lifetime spend with no formalised retention programme currently in place.

| Metric | Value |
|---|---|
| Total revenue | ~$908,230 |
| Total transactions | ~1,987 |
| Top revenue category | Electronics — $311,445 |
| Highest order volume | Clothing — 698 orders |
| Widest customer reach | Clothing — 149 unique buyers |
| Peak trading shift | Evening — 1,062 orders (53%+) |
| Best month (2022) | July — avg. $541/sale |
| Best month (2023) | February — avg. $536/sale |
| Top customer lifetime spend | Customer #3 — $38,440 |
| Avg. Beauty shopper age | 40.4 years |

---

## Problem Statement

Edison Retail is a business with a diverse product catalogue spanning multiple categories including Clothing, Beauty, and Electronics that needed a structured way to understand its sales performance, customer behaviour, and operational patterns. The company held a rich dataset of point-of-sale transactions but lacked the analytical framework to extract meaningful business insights from it.

The core business challenge was: **how can transaction-level data be transformed into intelligence that drives smarter decisions around product strategy, customer targeting, and staffing?**

Without clear visibility into who is buying, what is selling, when peak activity occurs, and which customers drive the most revenue, the business risked making strategic decisions on intuition alone.

---

## Project Objectives

1. **Clean and validate** the transaction dataset to ensure analytical integrity before drawing conclusions.
2. **Establish baseline metrics**  total sales volume, unique customer count, and category breadth.
3. **Analyse category performance** to identify which product lines generate the most revenue and order volume.
4. **Profile customers** by demographics (age, gender) and purchasing behaviour across categories.
5. **Uncover temporal trends** identifying peak sales months per year and busiest trading shifts by time of day.
6. **Rank top customers** by total spend to support loyalty and retention strategies.
7. **Segment transactions by shift** to provide operational insight for staffing and inventory planning.

---

## Project Overview

This project was delivered as a retail analytics brief. Using a single relational table of retail transaction records, a series of structured SQL queries were developed to answer 10 targeted business questions covering data quality assessment, sales analysis, customer intelligence, and operational insights.

The analysis was designed to be immediately actionable each query maps to a specific business decision, from understanding which categories to prioritise to knowing when the store is busiest.

### Database Schema

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

### Business Questions

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

## Key Insights

| # | Insight | Metric |
|---|---|---|
| 1 | **Electronics is the revenue engine**  :leads all categories in net revenue, narrowly ahead of Clothing | $311,445 vs. $309,995 |
| 2 | **Evening dominates trading** :more than half of all orders occur after 5 PM; mornings and afternoons are underutilised | 1,062 orders · 53%+ share |
| 3 | **A small group of customers drives outsized value** :the top 5 buyers contribute disproportionate revenue with no retention programme in place | Customer #3: $38,440 lifetime spend |
| 4 | **Seasonal peaks are predictable** : July and February consistently outperform other months by average sale value | July 2022: $541 avg · Feb 2023: $536 avg |
| 5 | **Beauty serves a defined, older demographic** : the avg. buyer is 40.4 years old, an under-leveraged targeting opportunity | Avg. age: 40.4 yrs |
| 6 | **Gender parity signals broad appeal** : a near-equal male/female split across all categories shows wide reach, but limits gender as a segmentation lever | Largest gap: 49 transactions (Clothing) |
| 7 | **Clothing has the widest customer reach** : highest unique customer count and order volume of all categories | 149 unique buyers · 698 orders |

---

## Strategic Recommendations

| # | Recommendation | Rationale |
|---|---|---|
| 1 | **Launch a VIP retention programme** : introduce tiered rewards, early access, and personalised outreach for top spenders | Customer #3 alone spent $38,440 with no structured loyalty mechanism in place |
| 2 | **Drive daytime traffic with targeted incentives** : morning flash deals or lunch-hour bundles to redistribute demand away from the evening peak | Evening holds 53%+ of orders; Morning (548) and Afternoon (377) are significantly underutilised |
| 3 | **Pre-load stock and campaigns for July and February** : plan promotions and increase inventory depth ahead of these recurring peak months | Both months outperform on avg. sale value across both years analysed |
| 4 | **Build a dedicated Beauty strategy for the 35–50 age bracket** :  develop age-appropriate messaging, curated product selections, and repeat-purchase incentives | Avg. Beauty buyer is 40.4 yrs — currently treated the same as other categories in marketing |
| 5 | **Protect the Electronics revenue lead through upselling** : introduce accessories, warranties, and bundles to grow avg. transaction value per order | Electronics leads on revenue but Clothing is less than $1,500 behind, with 20 more orders |
| 6 | **Compound Clothing's customer base advantage** : invest in referral incentives, new customer discounts, and seasonal collections | Clothing already has the widest reach (149 unique buyers) — the strongest acquisition category to scale |

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Database creation, data storage, and query execution |
| **MySQL (DDL & DML)** | Schema design, data cleaning, and analytical queries |
| **CASE Statements** | Data quality flagging and shift segmentation |
| **Window Functions** | `RANK()` for identifying best-selling months per year |
| **CTEs** | Structuring the shift analysis query cleanly |
| **Aggregate Functions** | `SUM()`, `COUNT()`, `AVG()`, `ROUND()` for business metrics |
| **Date & Time Functions** | `YEAR()`, `MONTH()`, `HOUR()`, `DATE_FORMAT()` for temporal analysis |

---

## Author

**Adebisi Farouk **
Business/Sales Analyst | SQL · Data Analysis · Retail Intelligence



---

