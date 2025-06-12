**WALMART SALES ANALYSIS USING MYSQL**

## 📌 Project Overview

This project focuses on analyzing Walmart's historical sales data using MySQL to extract meaningful insights. The goal is to understand top-performing branches and products, customer buying behavior, and how different time periods and holidays affect sales.

By executing various SQL queries on the dataset, we aim to answer key business questions and suggest strategies to improve sales performance.

## 📁 Dataset Source

The data for this project comes from a public Kaggle competition organized by Walmart. It includes historical sales data for 45 stores across various departments and includes holiday markdowns, which add complexity to sales forecasting.

<u><a href="https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting" target="_blank">
Walmart Sales Forecasting Competition - Kaggle</a></u>

## ⚙️ Tools and Technologies

- **Database**: MySQL (queries written and tested using MySQL Workbench)
- **Language**: SQL
- **Platform**: Local machine

## 🗂️ About Data

This dataset contains sales transactions from three different Walmart branches, located in **Mandalay**, **Yangon**, and **Naypyitaw**. It includes **17 columns** and **1000 rows** of data.

| Column                   | Description                                | Data Type          |
|--------------------------|--------------------------------------------|--------------------|
| `invoice_id`             | Invoice of the sales made                  | `VARCHAR(30)`      |
| `branch`                 | Branch at which sales were made            | `VARCHAR(5)`       |
| `city`                   | The location of the branch                 | `VARCHAR(30)`      |
| `customer_type`          | The type of the customer                   | `VARCHAR(30)`      |
| `gender`                 | Gender of the customer making purchase     | `VARCHAR(10)`      |
| `product_line`           | Product line of the product sold           | `VARCHAR(100)`     |
| `unit_price`             | The price of each product                  | `DECIMAL(10, 2)`   |
| `quantity`               | The amount of the product sold             | `INT`              |
| `VAT`                    | The amount of tax on the purchase          | `FLOAT(6, 4)`      |
| `total`                  | The total cost of the purchase             | `DECIMAL(12, 4)`   |
| `date`                   | The date on which the purchase was made    | `DATE`             |
| `time`                   | The time at which the purchase was made    | `TIMESTAMP`        |
| `payment_method`         | Payment method used                        | `VARCHAR(30)`      |
| `cogs`                   | Cost of Goods Sold                         | `DECIMAL(10, 2)`   |
| `gross_margin_percentage`| Gross margin percentage                    | `FLOAT(11, 9)`     |
| `gross_income`           | Gross income from the sale                 | `DECIMAL(12, 4)`   |
| `rating`                 | Customer rating                            | `FLOAT(2, 1)`      |

## 📊 Key Analysis Performed

- Top-performing branches based on total revenue
- Best-selling product categories
- Daily, weekly, and monthly sales trend analysis
- Customer purchase patterns (time of day, day of week)

## 🧭 Project Workflow & Methodology

To analyze the Walmart sales dataset effectively, I followed a structured yet flexible workflow. Here's a breakdown of the key steps I implemented:

### 1. Initial Data Cleaning
The first priority was to ensure the dataset was clean and reliable. I performed a thorough scan for missing or null values and removed them to avoid skewed insights during the analysis phase.

### 2. Feature Enrichment
To extract deeper time-based insights, I engineered a few additional columns:
- **`time_of_day`**: Classified each transaction as occurring in the Morning, Afternoon, or Evening based on the `time` field.
- **`day_name`**: Derived the weekday name (e.g., Monday, Saturday) from each transaction's `date`.
- **`month_name`**: Extracted the full month name for trend identification over longer periods.

These new features helped segment the data meaningfully for time series patterns and customer behavior analysis.

### 3.Exploratory Data Analysis (EDA)
With a clean and enriched dataset, I dived into exploratory analysis using SQL queries. The goal was to uncover patterns, outliers, and correlations. Some of the focal points included:
- Identifying the highest grossing branches and products
- Comparing sales across different times of day and days of the week
- Analyzing customer type and gender distribution
- Understanding payment method preferences
- Studying the seasonal or monthly sales fluctuations
- Looking at tax/VAT contributions and gross margins

### 4. 📈 Insight Derivation
The trends observed during EDA were compiled into actionable insights. For example, understanding peak shopping times and high-revenue locations helped form conclusions about potential operational improvements and sales strategy optimization.

---

This approach ensured that the analysis wasn’t just about writing queries—it focused on deriving real-world business insights from structured data.
## 💡 Business Questions Addressed

Below is a list of business-focused questions that guided the SQL analysis for this project. They are grouped into four core areas: General, Product, Sales, and Customer.

### 🏙️ General
- How many unique cities does the data have?
- In which city is each branch located?

### 📦 Product
- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- Which month had the highest Cost of Goods Sold (COGS)?
- Which product line generated the highest revenue?
- Which city had the highest overall revenue?
- Which product line had the largest VAT?
- For each product line, classify performance as "Good" or "Bad" based on whether sales exceed the average.
- Which branch sold more products than the average?
- What is the most common product line by gender?
- What is the average customer rating per product line?

### 💰 Sales
- Number of sales made during different times of day, across each weekday
- Which customer type brings in the most revenue?
- Which city has the highest VAT (Value Added Tax) percentage?
- Which customer type pays the most VAT?

### 👥 Customer
- How many unique customer types exist in the dataset?
- How many unique payment methods are used?
- What is the most common customer type?
- Which customer type purchases the most?
- What is the dominant gender among customers?
- What is the gender distribution for each branch?
- During which time of day do customers give the most ratings?
- What are the peak rating times per branch?
- Which day of the week has the best average ratings overall?
- Which day has the best average ratings per branch?




