SELECT * FROM retail_sales
limit 10;
-----------
SELECT COUNT(*) from retail_sales;
------------
SELECT * from retail_sales
WHERE sale_time is null
------------
SELECT * from retail_sales
WHERE 
     transactions_id is null
      OR
	  sale_date is null
	  OR
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR
	  age is null
	  OR
	  category is null
	  OR
	  quantiy is null
	  OR
	  price_per_unit is null
	  OR
	  cogs is null
	  OR
	  total_sale is null
-----------
	 DELETE FROM retail_sales
	 WHERE 
	 transactions_id is null
      OR
	  sale_date is null
	  OR
	  sale_time is null
	  OR
	  customer_id is null
	  OR
	  gender is null
	  OR
	  age is null
	  OR
	  category is null
	  OR
	  quantiy is null
	  OR
	  price_per_unit is null
	  OR
	  cogs is null
	  OR
	  total_sale is null
------DATA EXPLORATION
___How many sales we have
SELECT COUNT(*) as total_sale From retail_sales

----How many unique customers we have?
SELECT COUNT(DISTINCT customer_id)as total_sale FROM retail_sales
-----How many unique cartegory we have?
SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales
-----What are  the category we have
SELECT Distinct category FROM retail_sale

-----DATA ANALYSIS &BUSINESS  KEY Problems & Answers:
-- My analysis and findigs
--Q1 Write a sql query to retrieve all the columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date = '2022-11-05'

--Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM retail_sales
WHERE category='Clothing'
  AND
  TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
  AND 
  quantiy>=4

----Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, sum(total_sale) as net_sale,
COUNT(*)as total_orders
FROM retail_sales
GROUP BY 1

----Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
     ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE  category='Beauty'

----Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_sales
WHERE total_sale>1000

---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(*) as total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender

---Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,
       month,
	   avg_sale
FROM
(
   SELECT 
       EXTRACT(YEAR FROM sale_date) as year,
       EXTRACT(MONTH FROM sale_date) as month,
	   AVG(total_sale) as avg_sale,
	   RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC)
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank =1
--ORDER BY 1, 3 DESC

---Q8.Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
       SUM(total_sale)as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
limit 5

---Q9.Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
       category,
	   COUNT(DISTINCT customer_id) as count_unique_cs
FROM retail_sales
GROUP BY 1

---Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale 
AS
 (
  SELECT *,
      CASE
	      WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
	   END as shift 
  FROM retail_sales
 )
SElECT 
     shift,
     COUNT(*)as total_orders
FROM hourly_sale
GROUP BY shift

 --End Of Project
