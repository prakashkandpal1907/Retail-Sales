CREATE DATABASE retail_sales_project;

-- Create Tabel
CREATE TABLE retail_sales
				(
                transactions_id	INT PRIMARY KEY,
                sale_date DATE,
                sale_time TIME,	
                customer_id	INT,
                gender VARCHAR(15),
                age	INT,
                category VARCHAR(20),	
                quantiy	INT,
                price_per_unit	FLOAT,
                cogs FLOAT,	
                total_sale FLOAT
                );

SELECT * FROM retail_sales;

-- 1. Total Sales by Product Category
SELECT category, SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 2. Top 10 Average Sales Per Customer 
SELECT customer_id, AVG(total_sale) AS avg_sale_per_customer
FROM retail_sales
GROUP BY customer_id
ORDER BY avg_sale_per_customer DESC
LIMIT 10;

-- 3. Top 10 Monthly Sales Trend
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sale_month, 
       SUM(total_sale) AS monthly_revenue
FROM retail_sales
GROUP BY sale_month
ORDER BY sale_month
LIMIT 10;

-- 4. Top 5 Customers by Total Revenue
SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 5. Sales by Gender
SELECT gender, COUNT(*) AS num_transactions, 
       SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY gender;

-- 6. Peak Sales Hours (based on sale_time)
SELECT HOUR(sale_time) AS hour_of_day, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY hour_of_day
ORDER BY total_sales DESC;

-- 7. Create a View for Category-wise Monthly Sales
CREATE VIEW category_monthly_sales AS
SELECT category, DATE_FORMAT(sale_date, '%Y-%m') AS month,
       SUM(total_sale) AS monthly_sales
FROM retail_sales
GROUP BY category, month;



-- 8. Subquery – Customers with Sales Above Average
SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_sale) FROM retail_sales
);

-- 9. Index for Optimization
CREATE INDEX idx_sale_date ON retail_sales(sale_date);

