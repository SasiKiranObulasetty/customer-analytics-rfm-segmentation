CREATE DATABASE customer_analytics;
USE customer_analytics;
SELECT DATABASE();
CREATE TABLE transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    Revenue DECIMAL(12,2)
);
SHOW TABLES;
CREATE TABLE customer_segments (
    CustomerID INT PRIMARY KEY,
    Recency INT,
    Frequency INT,
    Monetary DECIMAL(12,2),
    AverageOrderValue DECIMAL(12,2),
    Segment VARCHAR(50)
);
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    Country VARCHAR(100)
);
SHOW TABLES;
USE customer_analytics;

SELECT COUNT(*) AS transaction_count
FROM transactions;
SELECT *
FROM transactions
LIMIT 10;
USE customer_analytics;

SELECT COUNT(*) AS customer_count
FROM customer_segments;
SELECT
    Segment,
    COUNT(*) AS Customers
FROM customer_segments
GROUP BY Segment
ORDER BY Customers DESC;
INSERT INTO customers (CustomerID, Country)
SELECT
    CustomerID,
    MAX(Country) AS Country
FROM transactions
GROUP BY CustomerID;
SELECT COUNT(*) AS customer_count
FROM customers;
SELECT
    (SELECT COUNT(*) FROM transactions) AS Transactions,
    (SELECT COUNT(*) FROM customers) AS Customers,
    (SELECT COUNT(*) FROM customer_segments) AS SegmentedCustomers;
-- =====================================================
-- Customer Segmentation & Marketing Analytics
-- SQL Analysis
-- Database: customer_analytics
-- =====================================================

USE customer_analytics;
-- 1. Total Revenue

SELECT
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM transactions;
-- 2. Total Orders

SELECT
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM transactions;
-- 3. Total Customers

SELECT
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM transactions;
-- 4. Average Order Value

SELECT
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS Average_Order_Value
FROM transactions;
-- 5. Revenue by Country

SELECT
    Country,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM transactions
GROUP BY Country
ORDER BY Total_Revenue DESC;
-- 6. Top 10 Customers by Revenue

SELECT
    CustomerID,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM transactions
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 10;
-- 7. Customer Count by Segment

SELECT
    Segment,
    COUNT(*) AS Customers
FROM customer_segments
GROUP BY Segment
ORDER BY Customers DESC;
-- 8. Revenue Contribution by Segment

SELECT
    Segment,
    COUNT(*) AS Customers,
    ROUND(SUM(Monetary), 2) AS Total_Revenue,
    ROUND(AVG(Monetary), 2) AS Avg_Customer_Revenue
FROM customer_segments
GROUP BY Segment
ORDER BY Total_Revenue DESC;
-- 9. Segment Performance

SELECT
    Segment,
    COUNT(*) AS Customers,
    ROUND(AVG(Recency), 2) AS Avg_Recency,
    ROUND(AVG(Frequency), 2) AS Avg_Frequency,
    ROUND(AVG(Monetary), 2) AS Avg_Monetary,
    ROUND(AVG(AverageOrderValue), 2) AS Avg_Order_Value
FROM customer_segments
GROUP BY Segment
ORDER BY Avg_Monetary DESC;
-- 10. Rank Customers by Monetary Value

SELECT
    CustomerID,
    Segment,
    Monetary,
    RANK() OVER (
        ORDER BY Monetary DESC
    ) AS Revenue_Rank
FROM customer_segments
ORDER BY Revenue_Rank
LIMIT 20;
-- 11. Identify High-Value Customers

SELECT
    CustomerID,
    Segment,
    Monetary,
    Frequency,
    Recency,
    CASE
        WHEN Monetary >= 5000 THEN 'High Value'
        WHEN Monetary >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Value_Category
FROM customer_segments
ORDER BY Monetary DESC;
-- 12. VIP Customer Analysis

SELECT
    COUNT(*) AS VIP_Customers,
    ROUND(SUM(Monetary), 2) AS VIP_Revenue,
    ROUND(AVG(Monetary), 2) AS Avg_VIP_Revenue,
    ROUND(AVG(Frequency), 2) AS Avg_VIP_Frequency,
    ROUND(AVG(Recency), 2) AS Avg_VIP_Recency
FROM customer_segments
WHERE Segment = 'VIP Customers';
-- 12. VIP Customer Analysis

SELECT
    COUNT(*) AS VIP_Customers,
    ROUND(SUM(Monetary), 2) AS VIP_Revenue,
    ROUND(AVG(Monetary), 2) AS Avg_VIP_Revenue,
    ROUND(AVG(Frequency), 2) AS Avg_VIP_Frequency,
    ROUND(AVG(Recency), 2) AS Avg_VIP_Recency
FROM customer_segments
WHERE Segment = 'VIP Customers';
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Orders,
    ROUND(SUM(Revenue), 2) AS Revenue
FROM transactions
WHERE CustomerID IN (
    SELECT c.CustomerID
    FROM customers c
    LEFT JOIN customer_segments s
        ON c.CustomerID = s.CustomerID
    WHERE s.CustomerID IS NULL
)
GROUP BY CustomerID;
SELECT
    CustomerID,
    MIN(InvoiceDate) AS First_Purchase,
    MAX(InvoiceDate) AS Last_Purchase,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    ROUND(SUM(Revenue), 2) AS Monetary
FROM transactions
WHERE CustomerID IN (15802, 15823, 16742, 17846)
GROUP BY CustomerID
ORDER BY CustomerID;
SELECT
    CustomerID,
    COUNT(*) AS Transaction_Rows,
    COUNT(DISTINCT InvoiceNo) AS Orders,
    SUM(Revenue) AS Revenue,
    MIN(InvoiceDate) AS First_Purchase,
    MAX(InvoiceDate) AS Last_Purchase
FROM transactions
WHERE CustomerID IN (15802, 15823, 16742, 17846)
GROUP BY CustomerID;
USE customer_analytics;

TRUNCATE TABLE customer_segments;  
SELECT COUNT(*) AS SegmentedCustomers
FROM customer_segments;
SELECT
    Segment,
    COUNT(*) AS Customers,
    ROUND(SUM(Monetary), 2) AS Revenue
FROM customer_segments
GROUP BY Segment
ORDER BY Revenue DESC;      