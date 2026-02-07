/* =========================================================
   PROJECT: Walmart Sales Analysis
   DATABASE: walmart
   TABLE: walmartsalesdata
   PURPOSE: Business-driven sales, profit, and customer analysis
   ========================================================= */


/* =========================
   DATABASE SETUP
   ========================= */

-- Create database for Walmart sales analytics
CREATE DATABASE walmart;

-- Use the Walmart database
USE walmart;

/* =========================
   DATA VALIDATION
   ========================= */

-- Validate total number of records loaded
SELECT COUNT(*) AS total_transactions
FROM walmartsalesdata;

-- Check date range of available data
SELECT 
    MIN(date) AS data_start_date,
    MAX(date) AS data_end_date
FROM walmartsalesdata;


/* =========================
   OVERALL BUSINESS PERFORMANCE
   ========================= */

-- Calculate total revenue and total profit
-- Used for executive-level performance reporting
SELECT 
    SUM(total) AS total_sales,
    SUM(gross_income) AS total_profit
FROM walmartsalesdata;


/* =========================
   BRANCH PERFORMANCE ANALYSIS
   ========================= */

-- Compare sales performance across branches
-- Helps identify high and low performing locations
SELECT 
    branch,
    SUM(total) AS branch_sales
FROM walmartsalesdata
GROUP BY branch
ORDER BY branch_sales DESC;


/* =========================
   PRODUCT PERFORMANCE ANALYSIS
   ========================= */

-- Identify top 5 product lines by units sold
-- Used for demand forecasting and inventory planning
SELECT 
    product_line,
    SUM(quantity) AS total_units_sold
FROM walmartsalesdata
GROUP BY product_line
ORDER BY total_units_sold DESC
LIMIT 5;

-- Analyze revenue contribution by product line
-- Helps prioritize high-revenue categories
SELECT 
    product_line,
    SUM(total) AS product_revenue
FROM walmartsalesdata
GROUP BY product_line
ORDER BY product_revenue DESC;


/* =========================
   CUSTOMER BEHAVIOR ANALYSIS
   ========================= */

-- Analyze sales by customer type
-- Supports loyalty and retention strategies
SELECT 
    customer_type,
    SUM(total) AS total_sales
FROM walmartsalesdata
GROUP BY customer_type;

-- Analyze sales distribution by gender
-- Helps understand demographic buying patterns
SELECT 
    gender,
    SUM(total) AS total_sales
FROM walmartsalesdata
GROUP BY gender;


/* =========================
   TIME-BASED SALES ANALYSIS
   ========================= */

-- Monthly sales trend analysis
-- Used for seasonality and sales forecasting
SELECT 
    MONTH(date) AS sales_month,
    SUM(total) AS monthly_sales
FROM walmartsalesdata
GROUP BY sales_month
ORDER BY sales_month;

-- Identify peak sales hours
-- Supports staffing and operational planning
SELECT 
    HOUR(time) AS sales_hour,
    SUM(total) AS hourly_sales
FROM walmartsalesdata
GROUP BY sales_hour
ORDER BY hourly_sales DESC;


/* =========================
   PAYMENT METHOD ANALYSIS
   ========================= */

-- Identify most frequently used payment methods
-- Helps evaluate customer payment preferences
SELECT 
    payment,
    COUNT(*) AS transaction_count
FROM walmartsalesdata
GROUP BY payment
ORDER BY transaction_count DESC;

-- Calculate average transaction value by payment method
-- Used to understand spending behavior
SELECT 
    payment,
    ROUND(AVG(total), 2) AS avg_transaction_value
FROM walmartsalesdata
GROUP BY payment;


/* =========================
   PROFITABILITY ANALYSIS
   ========================= */

-- Analyze profit contribution by branch
-- Helps management optimize costs and investments
SELECT 
    branch,
    SUM(gross_income) AS branch_profit
FROM walmartsalesdata
GROUP BY branch
ORDER BY branch_profit DESC;

-- Calculate profit margin by product line
-- Used to evaluate pricing and cost efficiency
SELECT 
    product_line,
    ROUND(SUM(gross_income) / SUM(total) * 100, 2) AS profit_margin_percentage
FROM walmartsalesdata
GROUP BY product_line
ORDER BY profit_margin_percentage DESC;


/* =========================
   CUSTOMER SATISFACTION ANALYSIS
   ========================= */

-- Analyze average customer rating by product line
-- Identifies products impacting customer experience
SELECT 
    product_line,
    ROUND(AVG(rating), 2) AS average_rating
FROM walmartsalesdata
GROUP BY product_line
ORDER BY average_rating DESC;

-- Compare customer satisfaction across branches
-- Used for service quality improvement
SELECT 
    branch,
    ROUND(AVG(rating), 2) AS average_rating
FROM walmartsalesdata
GROUP BY branch;


/* =========================
   ADVANCED BUSINESS QUERY
   ========================= */

-- Identify highest value transaction in each branch
-- Useful for high-value customer and anomaly analysis
SELECT *
FROM walmartsalesdata
WHERE total IN (
    SELECT MAX(total)
    FROM walmartsalesdata
    GROUP BY branch
);


/* =========================
   END OF PROJECT
   ========================= */
