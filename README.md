# SQL-Project-on-Walmart-Sales
Project Summary: Walmart Sales Analysis
1. Project Overview:
This project involves the creation of a database named WALMART_SALES to analyze sales data for a retail business. It provides insights into various aspects of sales, including customer types, product performance, and time-based trends.

2. Database Structure:
Database: WALMART_SALES
Primary Table: sales
Columns:
invoice_id (Primary Key): Unique identifier for each sale.
branch: Store branch where the sale occurred.
city: City corresponding to the branch.
customer_type: Type of customer (e.g., Member or Walk-in).
gender: Gender of the customer.
product_line: The category of the product sold (e.g., Electronics, Groceries).
unit_price: Price per unit of the product.
quantity: Number of units sold.
tax_pct: Tax percentage applied to the sale.
total: Total amount for the sale, including tax.
date and time: When the sale occurred.
payment: Payment method used (e.g., Credit Card, Cash).
cogs (Cost of Goods Sold): Cost incurred by the company for the products sold.
gross_margin_pct: Gross margin percentage for the sale.
gross_income: Gross income generated from the sale.
rating: Customer satisfaction rating (scale of 1–10).
3. Additional Features:
Derived Columns:
Time of Day: A column derived from the time field to categorize sales into:
Morning
Afternoon
Evening
Queries:
Select all records from the sales table (SELECT * FROM sales;).
4. Potential Insights from the Data:
Branch-wise Sales Performance: Compare total sales across different branches.
Customer Type Analysis: Evaluate which customer type contributes the most revenue.
Product Line Performance: Identify top-performing product categories.
Gender Trends: Analyze purchasing patterns by gender.
Time-based Analysis: Determine peak shopping hours (Morning, Afternoon, or Evening).
Customer Ratings: Assess customer satisfaction levels and their correlation with sales.
5. Business Use Cases:
Marketing Strategy: Tailor promotions to specific cities, branches, or customer demographics.
Inventory Management: Optimize stock levels based on product performance.
Customer Retention: Improve services for high-rating customers.
Financial Planning: Analyze gross margins and COGS to enhance profitability.
