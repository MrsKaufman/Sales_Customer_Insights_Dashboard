-- SQL Queries for Sales & Customer Insights Dashboard
-- Author: Melanie Kaufman
-- Description: KPIs and analysis for e-commerce dataset

-- 1. Monthly Revenue Trend
SELECT 
  STRFTIME('%Y-%m', "Order Date") AS Month,
  SUM("Sales Amount") AS Total_Revenue
FROM sales_data
GROUP BY Month
ORDER BY Month;

-- 2. Top 10 Products by Total Sales
SELECT 
  Product,
  SUM("Sales Amount") AS Total_Sales
FROM sales_data
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;

-- 3. Revenue by Region
SELECT 
  Region,
  SUM("Sales Amount") AS Revenue
FROM sales_data
GROUP BY Region;

-- 4. Average Order Value (AOV)
SELECT 
  AVG("Sales Amount") AS Average_Order_Value
FROM sales_data;

-- 5. Repeat Customer Rate
SELECT 
  COUNT(DISTINCT "Customer ID") AS Total_Customers,
  COUNT(DISTINCT CASE WHEN order_count > 1 THEN "Customer ID" END) AS Repeat_Customers,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN order_count > 1 THEN "Customer ID" END) / COUNT(DISTINCT "Customer ID"), 2) AS Repeat_Rate
FROM (
  SELECT "Customer ID", COUNT(*) AS order_count
  FROM sales_data
  GROUP BY "Customer ID"
);
