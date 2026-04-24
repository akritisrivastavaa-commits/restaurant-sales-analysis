  -- Restaurant Sales Analysis (SQL Project) --
  
  -- 1. Database Setup --

CREATE DATABASE restraunt_orders;
USE restraunt_orders;
SELECT * FROM orders;

-- 2. Data Cleaning & Preparation --

-- Standardizing Data --

ALTER TABLE orders
CHANGE `Order ID` order_id INT,
CHANGE `Customer Name` customer_name TEXT,
CHANGE `Food Item` food_item TEXT,
CHANGE `Quantity` quantity INT,
CHANGE `Price` price DECIMAL(6,2),
CHANGE `Payment Method` payment_method TEXT,
CHANGE `Order Time` order_time DATETIME;


-- Check for Duplicate Data --

SELECT order_id, COUNT(*) 
FROM orders
GROUP BY order_id
HAVING count(*) >1;

--  Checking Categorial Consistency --
SELECT DISTINCT customer_name FROM orders;

SELECT DISTINCT category FROM orders;

SELECT DISTINCT payment_method FROM orders;

-- Create Revenue Column --

ALTER TABLE orders ADD COLUMN revenue DECIMAL(10,2);


UPDATE orders SET revenue = quantity * price;

SELECT count(*) FROM orders;

-- 3. Exploratory Data Analysis --

-- 3.1 Overall Sales Performance --

SELECT COUNT(*) AS total_order, 
SUM(revenue) AS total_revenue, 
AVG(revenue) AS Avg_revenue
FROM orders;

-- 3.2 Product Performance --

-- Top 5 Items Sold --

select  food_item, sum(quantity) as total_quantity from orders
group by food_item
order by total_quantity DESC
limit 5 ;

-- Top 5 Items by Revenue --

select food_item, sum(revenue) as total_revenue from orders
group by food_item
order by total_revenue DESC
limit 5;

-- 3.3 Category Analysis --

--  Total items sold per category --

select category, sum(quantity) as total_items from orders
group by category
order by total_items desc;

-- Revenue Contribution by Category --

select category, sum(revenue) as total_revenue from orders
group by category
order by total_revenue desc;

-- 3.4 Payment Method Analysis

-- Number of orders per payment method --

select payment_method, count(*) as total_order from orders
group by payment_method
order by total_order desc ;

-- Revenue per payment method --

select payment_method, sum(revenue) as total_revenue from orders
group by payment_method
order by total_revenue desc;

-- 3.5 Time Analysis --

-- Order by hour --

select hour(order_time) as hour_time, count(*) as total_order  from orders
group by hour_time
order by total_order desc;















