select * from retail_sales

select * from retail_sales
where 
	transactions_id is null
	or 
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_Sale is null
	or 
	price_per_unit is null;

delete from retail_Sales
where 
	transactions_id is null
	or 
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or 
	total_Sale is null
	or 
	price_per_unit is null;

select count(*) from retail_sales	

select distinct category as name_category from retail_Sales

select count(distinct category) as name from retail_Sales

-- data analysis

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_Sales;

select * from retail_Sales
where sale_date  =  '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales
where category = 'Clothing' and quantiy>=4 and to_char(sale_date,'yyyy-mm') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as total_sales,count(*) as total_order from retail_Sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select customer_id,gender,category,avg(age) from retail_Sales
where category = 'Beauty'
group by customer_id,gender,category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender,category,count(transactions_id) as total_number from retail_Sales
group by gender,category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year,month,avg_sale
from 
(select extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_Sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)
from retail_sales
group by year,month
) as t2
where rank  = 1




-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,sum(total_Sale) as total_sales from retail_sales
group by customer_id
order by total_sales desc 
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


select category, count(distinct customer_id) as unique_cust from retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hour_style as
(select *,
	case
	when extract(hour from sale_time) <12 then 'Morning'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end as shift
From retail_Sales)
select shift,count(*) as total_orders from hour_style
group by shift

--end of project

 
