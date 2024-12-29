--  CREATE DATABASE-----
CREATE DATABASE WALMART_SALES;
-- USE DATABASE----
USE WALMART_SALES;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

SELECT * FROM sales;

 -- ADD TIME OF THE DAY COLUMNN ---
 ---------------------------------------------
 SELECT time ,
 (CASE 
         WHEN time Between "00:00:00" and "12:00:00" Then "Morning"
	WHEN time Between "12:01:00" and "16:00:00" Then "Afternoon"
    else "Evening"
    END) AS time_of_day
    from sales;
    
    ALTER TABLE SALES ADD COLUMN time_of_day varchar(20);
    
    UPDATE SALES
    SET time_of_day= (
    CASE 
         WHEN time Between "00:00:00" and "12:00:00" Then "Morning"
	WHEN time Between "12:01:00" and "16:00:00" Then "Afternoon"
    else "Evening"
    END);
    
    -- Add day_name column
    select date,
    dayname(date)
    from sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);
-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;

 -------- Product----------------------------------------------
 -- How many unique product_line does the data have ? 
 select distinct product_line from sales;
 
---- What is the most common payment method?---------- 
 select payment , count(*) as count  
 from sales 
 group by payment 
 order by count desc 
 limit 1;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;
 
 ---- what is the toal revenue by month ?----------------
 select sum(total) as total_revenue,month_name  
 from sales
 group by month_name
 order by total_revenue;
 
 -- What month had the largest COGS?--------------

 select sum(cogs)as cogs , month_name 
 from sales
 group by month_name
 order by cogs;
 
 -- What product line had the largest revenue?
select
	product_line,
	SUM(total) as total_revenue
from sales
group by  product_line
order by total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- What product line had the largest VAT?
SELECT
	product_line,
	sum(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

 -- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
SELECT product_line ,total ,
 CASE 
    WHEN total>(SELECT AVG(total) as avg_sales FROM SALES) THEN "GOOD"
    ELSE "BAD" 
    END AS Performance 
from sales;

-- Which branch sold more products than average product sold?
SELECT branch, 
       SUM(quantity) AS total_products_sold
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(total_quantity) 
                        FROM (SELECT SUM(quantity) AS total_quantity 
                              FROM sales 
                              GROUP BY branch) AS branch_totals);
                              
-- What is the most common product line by gender
select gender, product_line, count(product_line) as common_product
from Sales
group by gender, product_line
order by common_product desc
limit 1;  

-- What is the average rating of each product line
select round(avg(rating),2) as avg_rating,product_line 
from sales
group by product_line
order by avg_rating desc;
-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------
-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;
-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT customer_type, SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_type
ORDER BY total_quantity DESC
LIMIT 1;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT branch, 
       gender, 
       COUNT(*) AS total_customers
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender;

-- Which time of the day do customers give most ratings?
select time_of_day,max(rating)as
total_rating
from sales
group by time_of_day
order by total_rating desc;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?
select time_of_day,branch,max(rating) as 
total_rating
from sales
group by time_of_day,branch
order by total_rating desc;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------
-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT 
    customer_type, 
    SUM(total)as
    total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC
LIMIT 1;


-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(max(tax_pct), 2)as 
    tax_pct
FROM sales
GROUP BY city 
ORDER BY tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	sum(tax_pct)
    AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------                          


