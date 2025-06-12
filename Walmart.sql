------------------------------------------------------------------------------------------------------
-----------------------------------------_Create Database_--------------------------------------------
------------------------------------------------------------------------------------------------------

CREATE  DATABASE IF NOT EXISTS WalmartSales;

--------------------------------------------------------------------------------------------------------
----------------------------------------_Create Table_--------------------------------------------------
---------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    vat FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_percentage FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
---------------------------------------------------------------------------------------------------------------
--------------------------------------Importing_Data_from_External_File--------------------------------------
----------------------------------------------------------------------------------------------------------------

    SELECT * FROM sales;
    
--------------------------------------------------------------------------------------------------------------
------------------------------------------Feature Engineering(Add_time_of_day)--------------------------------
--------------------------------------------------------------------------------------------------------------

SELECT 
	time,
    (CASE
			WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "After Noon"
			WHEN `time` BETWEEN "16:01:00" AND "19:00:00" THEN "Evening"
            ELSE "Night"
	END
    ) AS time_of_day
    FROM sales;
------------------------------------------Table_Alter------------------------------------------
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
--------------------------------------Updating_the_table-------------------------------------------
UPDATE sales 
SET time_of_day=(
CASE
			WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "After Noon"
			WHEN `time` BETWEEN "16:01:00" AND "19:00:00" THEN "Evening"
            ELSE "Night"
	END
    );
    --------------------------------------------------------------------------------------------
    --------------------------------Feature Engineering(day_name)--------------------------------
    ---------------------------------------------------------------------------------------------
    
    SELECT 
    ( DAYNAME(date))AS day_name
    FROM sales;
	--------------------------------------Table_Alter-----------------------------------------
	ALTER TABLE sales ADD COLUMN day_name VARCHAR(30);
	--------------------------------------Update_Table--------------------------------------
    UPDATE  sales
    SET day_name=DAYNAME(date);
    
    -------------------------------------------------------------------------------------------
    ------------------------------Feature Engineering(Add_Month_Name)-------------------------
    --------------------------------------------------------------------------------------------
    
    SELECT (
    MONTHNAME(date)) AS month_name
    FROM sales;
    -------------------------------ALter_Table------------------------------------------
    ALTER TABLE sales ADD COLUMN month_name VARCHAR(30);
    -------------------------------UPDATE_TABLE ------------------------------------------
    UPDATE sales
    SET month_name= MONTHNAME(date);
    
---------------------------------------------------------------------------------------------------
----------------------------------------------PRODUCTS---------------------------------------------
----------------------------------------------------------------------------------------------------
			
		--------------- How many unique cities does the data have?--------------
  
  SELECT COUNT(distinct(city))
   FROM sales;

		-------In which city is each branch?------------------------------------
  
  SELECT branch,city
   FROM sales
   GROUP BY city,branch;
   
		-----------------How many unique product lines does the data have?-----------
  
	SELECT COUNT(DISTINCT(product_line))
	FROM sales;
    
		--------------------------------What is the most common payment method?-------------
   
	SELECT payment,count(*) AS payment_count
	FROM sales
	GROUP BY payment
	ORDER BY payment_count DESC
	LIMIT 1;
    
	-----------What is the most selling product line?-----------------
  
  SELECT product_line,
  SUM(
   quantity)AS Qty
   FROM sales
   GROUP BY product_line
   ORDER BY Qty DESC
   LIMIT 1;
   
		----------What is the total revenue by month?--------------
  
  SELECT month_name,SUM(
   total) AS Revenue
   FROM sales
   GROUP BY month_name
   ORDER BY Revenue DESC;
   
		---------What month had the largest COGS?--------------
   SELECT month_name,SUM(
   COGS) AS cog
   FROM sales
   GROUP BY month_name
   ORDER BY cog DESC;
   
	-----------------------What product line had the largest revenue?----------------

SELECT product_line,SUM(total)AS Revenue
FROM sales
GROUP BY product_line
ORDER BY Revenue DESC
LIMIT 1;

		-----What is the city with the largest revenue?-----------

SELECT city, SUM(total) AS Revenue
FROM sales
GROUP BY city
ORDER BY Revenue
LIMIT 1;

	---------------------What product line had the largest VAT?---------

SELECT product_line,
SUM(vat) AS Tax
FROM sales
GROUP BY product_line
ORDER BY Tax DESC;

-----------Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales--------

SELECT product_line,
(CASE
	WHEN   total_sales>(SELECT AVG(total_sales) AS AVERAGE FROM 
										(SELECT product_line,sum(total) AS total_sales
                                        FROM sales
                                        GROUP BY product_line)AS Product_table
                                        )THEN "Good"
                                        ELSE "Bad"
    END)AS Review
    FROM(SELECT product_line,SUM(total) AS total_sales
		FROM sales
        GROUP BY product_line)AS Summary;
       
       ------------------------Which branch sold more products than average product sold?--------------------------------------------------------------
 
 SELECT 
	branch, 
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

	------------------------------------------------------What is the most common product line by gender?------------------

SELECT gender,product_line,
count(gender) AS Gender_count
FROM sales
GROUP BY gender,product_line
ORDER BY Gender_count DESC;

	----------------What is the average rating of each product line?------------------

SELECT product_line,
ROUND(AVG(rating),2) AS Avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

--------------------------------------------------------------------------------------------------------------
------------------------------------------------SALES---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

	------Number of sales made in each time of the day per weekday-----------

SELECT day_name, time_of_day, COUNT(*) AS sale_count
FROM sales
GROUP BY day_name, time_of_day
ORDER BY  sale_count DESC,time_of_day,day_name;

	------------------Which of the customer types brings the most revenue?----------------

SELECT customer_type,ROUND(SUM(total),2) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

	-----------------Which city has the largest tax percent/ VAT (Value Added Tax)?-------------

SELECT city,(SUM(vat))/100 AS VATcent
FROM sales
GROUP BY city
ORDER BY VATcent DESC;

	-------------------------Which customer type pays the most in VAT?-------------------------

SELECT customer_type, SUM(vat) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;


------------------------------------------------------------------------------------------------------------
---------------------------------------------------CUSTOMERS------------------------------------------------
-------------------------------------------------------------------------------------------------------------
	-----------------------How many unique customer types does the data have?--------------------
    
SELECT COUNT(DISTINCT(customer_type))
FROM sales;

	-----------------------------How many unique payment methods does the data have?---------------------
    
SELECT COUNT(DISTINCT(payment))
FROM sales;

	--------------------------What is the most common customer type?--------------------------------
    
SELECT customer_type,COUNT(*)AS common
FROM sales
GROUP BY customer_type
ORDER BY common DESC;

	------------------------------------Which customer type buys the most?--------------------------------
    
SELECT customer_type,ROUND(SUM(total),2)AS bought
FROM sales
GROUP BY customer_type
ORDER BY bought DESC;

	---------------------------------------What is the gender of most of the customers?----------------------
    
SELECT gender,count(*) AS most
FROM sales
GROUP BY gender
ORDER BY most DESC;

	---------------------------------------------What is the gender distribution per branch?------------------
    
SELECT branch,gender,count(*) AS most
FROM sales
GROUP BY branch,gender
ORDER BY branch,gender,most DESC;

	----------------------------------------Which time of the day do customers give most ratings?------------------
    
SELECT time_of_day,COUNT(rating) AS most
FROM sales
GROUP BY time_of_day
ORDER BY most DESC;

	------------------------------Which time of the day do customers give most ratings per branch?--------------------
    
SELECT branch,time_of_day,COUNT(rating) AS most
FROM sales
GROUP BY branch,time_of_day
ORDER BY branch,most DESC;

	-----------------------------------Which day fo the week has the best avg ratings?--------------------
    
SELECT day_name,ROUND(AVG(rating),2) AS avg_rate
FROM sales
GROUP BY day_name
ORDER BY avg_rate DESC;

	----------------------------Which day of the week has the best average ratings per branch?-------------
    
SELECT branch,day_name,ROUND(AVG(rating),2) AS avg_rate
FROM sales
GROUP BY branch,day_name
ORDER BY branch,avg_rate DESC;