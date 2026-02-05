#  Sales_SQL Analysis Project

## 📌 Overview
This project performs an end-to-end SQL analysis on a pizza sales dataset to uncover actionable business insights from transactional data.

Using SQL, we analyze sales performance, customer behavior, product popularity, and revenue trends. The project simulates real-world business intelligence tasks by transforming raw data into key performance indicators (KPIs) that support data-driven decision-making.
 
## 📊 Dataset
Download from Kaggle:  
👉 [Pizza Sales Dataset](https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset)

 Dataset (Local Files):

- [orders.csv](data/orders.csv)
- [order_details.csv](data/order_details.csv)
- [pizzas.csv](data/pizzas.csv)
- [pizza_types.csv](data/pizza_types.csv)
---

## 🛠 Tech Stack
- SQL (MySQL)
- Relational Database Design
- Aggregations & Joins
- Window Functions
- Subqueries
- Business KPI Analysis

---

## 📂 Database Schema

### Tables Used
- **orders** → order date & time
- **order_details** → pizza quantities per order
- **pizzas** → size & price information
- **pizza_types** → pizza names & categories

---

## 🎯 Business Problems Solved

### Sales Metrics
- Total number of orders
- Total revenue generated
- Average pizzas sold per day
- Cumulative revenue growth

### Product Insights
- Highest-priced pizza
- Most common pizza size
- Top 5 most ordered pizzas
- Top 3 pizzas by revenue
- Category-wise demand

### Customer Behavior
- Orders distribution by hour
- Daily ordering patterns
- Revenue contribution by category (%)

---

## 🔍 Key Results
- **21,350 total orders**
- **$817,860+ revenue generated**
- Peak demand during lunch & evening hours
- Few pizzas contribute majority of revenue (Pareto effect)

---

## 🧠 SQL Skills Demonstrated

### Core
- SELECT, WHERE, GROUP BY
- COUNT, SUM, AVG
- INNER JOIN

### Intermediate
- Multi-table joins
- Subqueries
- Aggregations with calculations

### Advanced
- Window functions (ROW_NUMBER, SUM OVER)
- Ranking & partitioning
- Cumulative revenue analysis
- Percentage contribution calculations

---

## 📜 Sample Queries

### Total Orders
```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

### Total Revenue
```sql
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;
```

### Top 3 Pizzas by Revenue
```sql
SELECT pt.name,
       SUM(od.quantity * p.price) AS revenue
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;
```

---

## 🚀 How to Run

1. Download dataset from Kaggle
2. Import CSV files into MySQL
3. Create tables
4. Execute queries from `analysis.sql`

---

## 💡 What This Project Demonstrates
✔ Writing optimized SQL queries  
✔ Performing business analytics with SQL  
✔ Data modeling & relational joins  
✔ Using window functions for advanced insights  
✔ Translating raw data into business KPIs  

---

## 📈 Future Improvements
- Power BI / Tableau dashboard
- Automated ETL pipeline
- Index optimization
- Stored procedures
- Time-series forecasting

---

## 👤 Author
Alphie Varghese  
Data Analyst | SQL | Business Intelligence
