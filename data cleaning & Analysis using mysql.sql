/* creating Database */
create database Pizza_DB;

/* using Database */
use Pizza_DB;

/* Table Creation */
create table pizza_sales(
pizza_id int,
order_id int,
pizza_name_id varchar(100),	
quantity int,	
order_date varchar(50),	
order_time time,	
unit_price float,	
total_price float,	
pizza_size varchar(5),	
pizza_category varchar(60),
pizza_ingredients varchar(150),	
pizza_name varchar(100)
);

/* Disabling safe updates */
set sql_safe_updates=0;

/* Converting the order_date column to the DATE data type */
update pizza_sales set order_date=STR_TO_DATE(order_date, '%d-%m-%Y');

/* Selecting all columns from the pizza_sales table */
select * from pizza_sales;

/* Calculating the total revenue from pizza sales */
select sum(total_price)  as total_revenue from pizza_sales;

/* Calculating the average value of each order */
select sum(total_price) /count(distinct order_id) as total_average_value from pizza_sales;

/* Calculating the total quantity of pizzas sold */
select sum(quantity) as total_pizza_sold from pizza_sales;

/* Counting the total number of orders */
select count(distinct order_id) as total_orders from pizza_sales;

/* Calculating the average number of pizzas per order */
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)
 as decimal(10,2)) as decimal(10,2)) as avg_pizza_per_order from pizza_sales;

/* Daily trend for total orders */
select dayname(order_date) as order_day,count(distinct order_id) as total_orders 
from pizza_sales group by dayname(order_date) order by total_orders desc; 

/* Hourly trend for orders */
select hour(order_time) as order_hours,count(distinct order_id) as total_orders 
from pizza_sales group by hour(order_time) order by total_orders ; 

/* Monthly trend for orders */
select monthname(order_date) as month_name ,count(distinct order_id) as total_orders from pizza_sales 
group by monthname(order_date) order by total_orders desc;
 
 /* . Total pizzas sold by pizza category */
select pizza_category ,sum(quantity) as total_quantity_sold from pizza_sales
group by pizza_category order by total_quantity_sold desc; 
 
 /* Calculating the percentage of total revenue for each pizza category */
select pizza_category,sum(total_price)*100/(select sum(total_price) from pizza_sales);

/* Calculating the percentage of total revenue for each pizza category in January */
SELECT pizza_category, SUM(total_price) as total_sales,SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales where month(order_date)=1) as PCT
FROM pizza_sales 
where month(order_date)=1
group by pizza_category;

/* Calculating the percentage of total revenue for each pizza category overall */
SELECT pizza_category, SUM(total_price) as total_revenue,cast(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) as decimal(10,2)) as PCT
FROM pizza_sales 
group by pizza_category
order by total_revenue desc;

/* Calculating the percentage of total revenue for each pizza size in the first quarter */
SELECT pizza_size, cast(SUM(total_price) as decimal(10,2))as total_sales,cast(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales where quarter(order_date)=1) as decimal(10,2)) as PCT
FROM pizza_sales 
where quarter(order_date)=1
group by pizza_size
order by PCT desc;

/* Calculating the percentage of total revenue for each pizza size overall */
SELECT pizza_size, cast(SUM(total_price) as decimal(10,2))as total_revenue,cast(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) as decimal(10,2)) as PCT
FROM pizza_sales 
group by pizza_size
order by pizza_size;

/* Finding the top 5 highest revenue-generating pizzas */
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

/* Finding the top 5 lowest revenue-generating pizzas */
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5;

/* Finding the top 5 highest quantity-sold pizzas */
select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5;

/* Finding the top 5 lowest quantity-sold pizzas */
select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc
limit 5;

/* Finding the top 5 highest ordered pizzas */
select pizza_name, count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc
limit 5;

/* Finding the top 5 lowest ordered pizzas */
select pizza_name, count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders asc
limit 5;


