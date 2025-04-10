# Retail_Sale_SQL_Analysis
Analyzed e-commerce retail sales data using SQL in MySQL Workbench. Created views, subqueries, and optimized queries to extract insights on customer behavior, sales trends, and product performance. Included screenshots, SQL scripts, and documentation for GitHub submission.
Project Structure
# Retail Sales Analysis SQL Project

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retail_sales_project;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```


### 2. Top 10 Average Sales Per Customer 
```sql
SELECT customer_id, AVG(total_sale) AS avg_sale_per_customer
FROM retail_sales
GROUP BY customer_id
ORDER BY avg_sale_per_customer DESC
LIMIT 10;
```

### 3. Top 10 Monthly Sales Trend
```sql
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sale_month, 
       SUM(total_sale) AS monthly_revenue
FROM retail_sales
GROUP BY sale_month
ORDER BY sale_month
LIMIT 10;
```

### 4. Top 5 Customers by Total Revenue
```sql
SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
```

### 5. Sales by Gender
```sql
SELECT gender, COUNT(*) AS num_transactions, 
       SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY gender;
```
### 6. Peak Sales Hours (based on sale_time)
```sql
SELECT HOUR(sale_time) AS hour_of_day, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY hour_of_day
ORDER BY total_sales DESC;
```

### 7. Create a View for Category-wise Monthly Sales
```sql
CREATE VIEW category_monthly_sales AS
SELECT category, DATE_FORMAT(sale_date, '%Y-%m') AS month,
       SUM(total_sale) AS monthly_sales
FROM retail_sales
GROUP BY category, month;
```
### 8. Subquery – Customers with Sales Above Average
```sql
SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_sale) FROM retail_sales
);
```
### 9. Index for Optimization
```sql
CREATE INDEX idx_sale_date ON retail_sales(sale_date);
```
