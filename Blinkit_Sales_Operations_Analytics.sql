CREATE DATABASE blinkit_sales;
USE blinkit_sales;
CREATE TABLE blinkit_orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    outlet_name VARCHAR(100),
    sales_channel VARCHAR(30),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    delivery_time_minutes INT,
    payment_method VARCHAR(30),
    order_status VARCHAR(30)
);

INSERT INTO blinkit_orders
(order_id, order_date, customer_id, product_name, category, outlet_name,
 sales_channel, quantity, unit_price, discount_percent,
 delivery_time_minutes, payment_method, order_status)
VALUES
(1, '2026-01-05', 101, 'Milk', 'Dairy', 'Pune Camp', 'App', 2, 30.00, 0, 12, 'UPI', 'Completed'),
(2, '2026-01-06', 102, 'Bread', 'Bakery', 'Kothrud', 'App', 1, 40.00, 5, 15, 'Card', 'Completed'),
(3, '2026-01-07', 103, 'Potato Chips', 'Snacks', 'Baner', 'Website', 3, 50.00, 10, 18, 'UPI', 'Completed'),
(4, '2026-01-08', 104, 'Shampoo', 'Personal Care', 'Hadapsar', 'App', 1, 250.00, 15, 22, 'Cash', 'Completed'),
(5, '2026-01-09', 105, 'Apples', 'Fruits', 'Viman Nagar', 'App', 2, 120.00, 5, 14, 'UPI', 'Cancelled');

select * from blinkit_orders;

SELECT product_name, category, unit_price FROM blinkit_orders;

select * from blinkit_orders where category='Dairy';

SELECT product_name, unit_price FROM blinkit_orders WHERE unit_price > 100;

select product_name,unit_price from blinkit_orders where category='Snacks' AND unit_price>40;

select product_name,unit_price from blinkit_orders where category='Dairy' or category='Bakery';

select product_name,unit_price from blinkit_orders order by unit_price asc;

select product_name,unit_price from blinkit_orders order by unit_price desc;

select product_name,unit_price from blinkit_orders order by unit_price desc limit 3;

select distinct category from blinkit_orders;

select count(*) as total_orders from blinkit_orders; 

select SUM(quantity * unit_price) as total_revenue from blinkit_orders;

select avg(quantity*unit_price) as average_order_value from blinkit_orders;

select min(unit_price) as minimun_price from blinkit_orders;

select max(unit_price)as maximum_price from blinkit_orders;

select category, count(*) as total_orders from blinkit_orders group by category;

select category, SUM(quantity*unit_price) as total_revenue from blinkit_orders group by category;

select category,SUM(quantity*unit_price) as total_revenue from blinkit_orders group by category order by total_revenue desc;

select category,SUM(quantity*unit_price) as total_revenue from blinkit_orders group by category having SUM(quantity*unit_price)>100;

select category,SUM(quantity*unit_price) as total_revenue from blinkit_orders where sales_channel='App' group by category
having SUM(quantity*unit_price)>100;

USE blinkit_sales;

select count(distinct customer_id) as unique_customers from blinkit_orders;

select customer_id,count(*) as total_orders from blinkit_orders group by customer_id order by total_orders desc;

select customer_id,SUM(quantity*unit_price)as total_revenue from blinkit_orders group by customer_id order by total_revenue desc;
   
 select customer_id,ROUND(SUM(quantity * unit_price), 2) AS total_revenue FROM blinkit_orders GROUP BY customer_id
ORDER BY total_revenue DESC;

select month(order_date) as order_month,sum(quantity * unit_price) as total_revenue from blinkit_orders group by month(order_date)
order by order_month;

select date_format(order_date, '%m') as order_month,sum(quantity * unit_price) as total_revenue from blinkit_orders
group by date_format(order_date, '%m') order by order_month;

select date_format(order_date, '%m') as order_month, sum(quantity * unit_price) as total_revenue from blinkit_orders
group by date_format(order_date, '%m') order by order_month;

select date_format(order_date, '%b') as order_month,sum(quantity * unit_price) as total_revenue from blinkit_orders
group by date_format(order_date, '%b') order by min(order_date);

select order_id,quantity*unit_price as order_value ,
case
when quantity*unit_price >200 then 'high'
when quantity * unit_price >= 100 then 'medium' else 'low'
end as order_value_category from blinkit_orders;

select order_id,discount_percent,case
        when discount_percent > 10 then 'high discount'
        when discount_percent >= 5 then 'medium discount'
        else 'low discount'
end as discount_category from blinkit_orders;

select product_name, unit_price from blinkit_orders where unit_price > (select avg(unit_price) from blinkit_orders);

select * from blinkit_orders where category in ('Dairy', 'Bakery', 'Snacks');

select product_name, unit_price from blinkit_orders where unit_price between 40 and 150;

select product_name, category, unit_price from blinkit_orders where product_name like '%a%';

select product_name, category, unit_price from blinkit_orders where product_name like '%a%';

select category,count(*) as total_orders from blinkit_orders group by category having count(*) > 2;

create table outlets (outlet_name varchar(100) primary key,city varchar(50),outlet_type varchar(50));

insert into outlets
(outlet_name, city, outlet_type)
values
('pune camp', 'pune', 'urban'),
('kothrud', 'pune', 'urban'),
('baner', 'pune', 'urban'),
('hadapsar', 'pune', 'urban'),
('viman nagar', 'pune', 'urban');

select b.order_id,b.product_name,b.outlet_name,o.city,o.outlet_type from blinkit_orders b inner join outlets o on 
lower(b.outlet_name) = lower(o.outlet_name);

use blinkit_sales;

select
    b.order_id,
    b.product_name,
    b.outlet_name,
    o.city,
    o.outlet_type
from blinkit_orders b
left join outlets o
    on lower(b.outlet_name) = lower(o.outlet_name);
    
select o.city,count(b.order_id) as total_orders from blinkit_orders b
left join outlets o on lower(b.outlet_name) = lower(o.outlet_name)group by o.city order by total_orders desc;

select o.city, sum(b.quantity * b.unit_price) as total_revenue from blinkit_orders b  left join outlets o
on lower(b.outlet_name) = lower(o.outlet_name) group by o.city order by total_revenue desc;

select o.city,sum(b.quantity * b.unit_price) as total_revenue from blinkit_orders b left join outlets o on lower(b.outlet_name) = lower(o.outlet_name)
group by o.city having sum(b.quantity * b.unit_price) > 200 order by total_revenue desc;

select b.order_id,b.product_name,coalesce(o.city, 'unknown') as city from blinkit_orders b
left join outlets o on lower(b.outlet_name) = lower(o.outlet_name);

with category_revenue as (select category,sum(quantity * unit_price) as total_revenue from blinkit_orders group by category)
select category,total_revenue from category_revenue where total_revenue > 100 order by total_revenue desc;

select product_name,quantity * unit_price as revenue,rank() over 
(order by quantity * unit_price desc) as revenue_rank from blinkit_orders;

select product_name,quantity * unit_price as revenue,row_number() over (order by quantity * unit_price desc) as row_numbers
from blinkit_orders;

select product_name,category,quantity * unit_price as revenue,row_number() over
(partition by category order by quantity * unit_price desc) as category_rank from blinkit_orders;

select product_name,category,quantity*unit_price as revenue,dense_rank() over(partition by category order by quantity*unit_price desc)
as category_rank from blinkit_orders;

select order_id,product_name,quantity*unit_price as revenue,lag(quantity*unit_price)over(order by order_id)as previous_revenue
from blinkit_orders;

select order_id,product_name,quantity * unit_price as revenue,lead(quantity * unit_price) over (order by order_id) as next_revenue
from blinkit_orders;

select order_id,product_name,quantity * unit_price as order_value,if(quantity * unit_price > 100, 'high value', 'low value')
as order_type from blinkit_orders;

select order_id,product_name,discount_percent,nullif(discount_percent, 0) as actual_discount
from blinkit_orders;

select product_name,category,concat(product_name, ' - ', category) as product_category from blinkit_orders;

select product_name,upper(product_name) as uppercase_name,lower(product_name) as lowercase_name
from blinkit_orders;

select product_name,trim(product_name) as cleaned_product_name from blinkit_orders;

select product_name,replace(product_name, 'a', 'A') as updated_name from blinkit_orders;

select order_date,year(order_date) as order_year,month(order_date) as order_month from blinkit_orders;

select order_date,dayname(order_date) as order_day from blinkit_orders;

select order_date,dayofweek(order_date) as weekday_number from blinkit_orders;

select order_date,date_format(order_date, '%d-%m-%Y') as formatted_date from blinkit_orders;

select order_id,order_date,datediff('2026-01-31', order_date) as days_difference from blinkit_orders;

select order_id,order_date,date_add(order_date, interval 7 day) as next_date from blinkit_orders;

select order_id,order_date,date_sub(order_date, interval 7 day) as previous_date from blinkit_orders;

select count(*) as completed_orders from blinkit_orders where order_status = 'Completed';

select sum(quantity * unit_price) as completed_revenue from blinkit_orders where order_status = 'Completed';

select round(avg(quantity * unit_price), 2) as average_completed_order_value from blinkit_orders
where order_status = 'Completed';

select order_status,count(*) as total_orders from blinkit_orders group by order_status order by total_orders desc;

select count(case when order_status = 'Completed' then 1 end) as completed_orders,count(case when order_status = 'Cancelled' then 1 end) as cancelled_orders
from blinkit_orders;

select round(count(case when order_status = 'Cancelled' then 1 end) * 100.0/ count(*),2) as cancellation_rate from blinkit_orders;

select customer_id,round(sum(quantity * unit_price), 2) as total_revenue from blinkit_orders group by
customer_id order by total_revenue desc;

select category,count(distinct customer_id) as unique_customers from blinkit_orders
group by category order by unique_customers desc;

select category,round(avg(unit_price), 2) as average_price from blinkit_orders group by category
order by average_price desc;

select
    sales_channel,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by sales_channel
order by total_revenue desc;

select
    sales_channel,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by sales_channel
order by total_revenue desc;

select
    sales_channel,
    round(sum(quantity * unit_price), 2) as completed_revenue
from blinkit_orders
where order_status = 'Completed'
group by sales_channel
order by completed_revenue desc;

select
    sales_channel,
    count(*) as completed_orders
from blinkit_orders
where order_status = 'Completed'
group by sales_channel
order by completed_orders desc;

select
    sales_channel,
    round(avg(quantity * unit_price), 2) as average_order_value
from blinkit_orders
group by sales_channel
order by average_order_value desc;

select
    order_id,
    product_name,
    quantity * unit_price as order_revenue
from blinkit_orders
where quantity * unit_price > (
    select avg(quantity * unit_price)
    from blinkit_orders
)
order by order_revenue desc;

select
    b.order_id,
    b.product_name,
    b.outlet_name
from blinkit_orders b
where exists (
    select 1
    from outlets o
    where lower(b.outlet_name) = lower(o.outlet_name)
);

select
    b.order_id,
    b.product_name,
    b.outlet_name
from blinkit_orders b
where not exists (
    select 1
    from outlets o
    where lower(b.outlet_name) = lower(o.outlet_name)
);

select product_name, category
from blinkit_orders
where category = 'Dairy'

union

select product_name, category
from blinkit_orders
where category = 'Bakery';

select product_name, category
from blinkit_orders
where category = 'Dairy'

union all

select product_name, category
from blinkit_orders
where category = 'Bakery';

create view completed_orders as
select
    order_id,
    product_name,
    category,
    quantity,
    unit_price,
    quantity * unit_price as order_revenue
from blinkit_orders
where order_status = 'Completed';

select * from completed_orders;

drop view completed_orders;

create index idx_order_date on blinkit_orders(order_date);

show index from blinkit_orders;

select
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue,
    round(avg(quantity * unit_price), 2) as average_order_value,
    count(distinct customer_id) as unique_customers,
    count(case when order_status = 'Completed' then 1 end) as completed_orders,
    count(case when order_status = 'Cancelled' then 1 end) as cancelled_orders,
    round(
        count(case when order_status = 'Cancelled' then 1 end) * 100.0
        / count(*),
        2
    ) as cancellation_rate
from blinkit_orders;

select
    category,
    count(*) as total_orders,
    sum(quantity) as total_quantity,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by category
order by total_revenue desc;

select
    outlet_name,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by outlet_name
order by total_revenue desc;

use blinkit_sales;

select outlet_name,round(avg(delivery_time_minutes), 2) as average_delivery_time
from blinkit_orders
group by outlet_name
order by average_delivery_time asc;

select payment_method,count(*) as total_orders,round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders group by payment_method order by total_revenue desc;

select product_name,round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders group by product_name order by total_revenue desc limit 3;

select category,round(sum(quantity * unit_price), 2) as total_revenue from blinkit_orders group by
category order by total_revenue desc limit 3;

select
    discount_percent,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by discount_percent
order by discount_percent;

select
    discount_percent,
    round(avg(quantity * unit_price), 2) as average_order_value,
    count(*) as total_orders
from blinkit_orders
group by discount_percent
order by discount_percent;

select
    order_id,
    delivery_time_minutes,
    case
        when delivery_time_minutes <= 15 then 'fast'
        when delivery_time_minutes <= 20 then 'medium'
        else 'slow'
    end as delivery_category
from blinkit_orders;

select
    case
        when delivery_time_minutes <= 15 then 'fast'
        when delivery_time_minutes <= 20 then 'medium'
        else 'slow'
    end as delivery_category,
    count(*) as total_orders
from blinkit_orders
group by delivery_category
order by total_orders desc;

select
    case
        when delivery_time_minutes <= 15 then 'fast'
        when delivery_time_minutes <= 20 then 'medium'
        else 'slow'
    end as delivery_category,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by delivery_category
order by total_revenue desc;

select
    customer_id,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue,
    round(avg(quantity * unit_price), 2) as average_order_value
from blinkit_orders
group by customer_id
order by total_revenue desc;

select
    customer_id,
    round(sum(quantity * unit_price), 2) as total_revenue,
    case
        when sum(quantity * unit_price) > 200 then 'high value'
        when sum(quantity * unit_price) >= 100 then 'medium value'
        else 'low value'
    end as customer_segment
from blinkit_orders
group by customer_id
order by total_revenue desc;

select
    customer_id,
    count(*) as total_orders,
    round(sum(quantity * unit_price), 2) as total_revenue
from blinkit_orders
group by customer_id
order by total_revenue desc
limit 3;

USE blinkit_sales;


WITH customer_segments AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS total_revenue,
        CASE
            WHEN SUM(quantity * unit_price) > 200 THEN 'High Value'
            WHEN SUM(quantity * unit_price) >= 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM blinkit_orders
    GROUP BY customer_id
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_revenue), 2) AS segment_revenue
FROM customer_segments
GROUP BY customer_segment
ORDER BY segment_revenue DESC;


SELECT
    customer_id,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM blinkit_orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_orders DESC, total_revenue DESC;

SELECT
    COUNT(*) AS repeat_customers,
    ROUND(SUM(total_revenue), 2) AS repeat_customer_revenue
FROM (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        SUM(quantity * unit_price) AS total_revenue
    FROM blinkit_orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS repeat_customers;

SELECT
    customer_id,
    ROUND(SUM(quantity * unit_price), 2) AS customer_revenue,
    ROUND(
        SUM(quantity * unit_price) * 100.0
        / (SELECT SUM(quantity * unit_price) FROM blinkit_orders),
        2
    ) AS revenue_contribution_percent
FROM blinkit_orders
GROUP BY customer_id
ORDER BY customer_revenue DESC;



SHOW TABLES;

SELECT
    customer_id,
    ROUND(SUM(quantity * unit_price), 2) AS customer_revenue,
    CASE
        WHEN SUM(quantity * unit_price) > 200 THEN 'High Value'
        WHEN SUM(quantity * unit_price) >= 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM blinkit_orders
GROUP BY customer_id
ORDER BY customer_revenue DESC;

SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(customer_revenue), 2) AS total_revenue
FROM (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS customer_revenue,
        CASE
            WHEN SUM(quantity * unit_price) > 200 THEN 'High Value'
            WHEN SUM(quantity * unit_price) >= 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM blinkit_orders
    GROUP BY customer_id
) AS customer_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;


SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(customer_revenue), 2) AS total_revenue,
    ROUND(
        SUM(customer_revenue) * 100.0 /
        (SELECT SUM(quantity * unit_price)
         FROM blinkit_orders),
        2
    ) AS revenue_contribution_percent
FROM (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS customer_revenue,
        CASE
            WHEN SUM(quantity * unit_price) > 200 THEN 'High Value'
            WHEN SUM(quantity * unit_price) >= 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM blinkit_orders
    GROUP BY customer_id
) AS customer_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;

SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(customer_revenue), 2) AS total_revenue,
    ROUND(AVG(customer_revenue), 2) AS avg_customer_revenue
FROM (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS customer_revenue,
        CASE
            WHEN SUM(quantity * unit_price) > 200 THEN 'High Value'
            WHEN SUM(quantity * unit_price) >= 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM blinkit_orders
    GROUP BY customer_id
) AS customer_data
GROUP BY customer_segment
ORDER BY avg_customer_revenue DESC;

SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(
        SUM(quantity * unit_price) / COUNT(DISTINCT order_id),
        2
    ) AS revenue_per_order
FROM blinkit_orders
GROUP BY customer_id
ORDER BY total_orders DESC, total_revenue DESC;

SELECT
    customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        CASE
            WHEN COUNT(DISTINCT order_id) > 1 THEN 'Repeat Customer'
            ELSE 'One-time Customer'
        END AS customer_type
    FROM blinkit_orders
    GROUP BY customer_id
) AS customer_behavior
GROUP BY customer_type
ORDER BY customer_count DESC;

SELECT
    customer_type,
    COUNT(*) AS customer_count,
    ROUND(SUM(customer_revenue), 2) AS total_revenue,
    ROUND(
        SUM(customer_revenue) * 100.0 /
        (SELECT SUM(quantity * unit_price)
         FROM blinkit_orders),
        2
    ) AS revenue_contribution_percent
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity * unit_price) AS customer_revenue,
        CASE
            WHEN COUNT(DISTINCT order_id) > 1 THEN 'Repeat Customer'
            ELSE 'One-time Customer'
        END AS customer_type
    FROM blinkit_orders
    GROUP BY customer_id
) AS customer_data
GROUP BY customer_type
ORDER BY total_revenue DESC;

SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS lifetime_revenue,
    ROUND(
        SUM(quantity * unit_price) / COUNT(DISTINCT order_id),
        2
    ) AS avg_order_value
FROM blinkit_orders
GROUP BY customer_id
ORDER BY lifetime_revenue DESC
LIMIT 10;

SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM blinkit_orders
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM blinkit_orders
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    category,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM blinkit_orders
GROUP BY category
ORDER BY total_revenue DESC;

SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(
        SUM(quantity * unit_price) * 100.0 /
        (SELECT SUM(quantity * unit_price)
         FROM blinkit_orders),
        2
    ) AS revenue_contribution_percent
FROM blinkit_orders
GROUP BY sales_channel
ORDER BY total_revenue DESC

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM blinkit_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;

SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0 /
        (SELECT COUNT(DISTINCT order_id) FROM blinkit_orders),
        2
    ) AS order_percentage
FROM blinkit_orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    MIN(delivery_time_minutes) AS fastest_delivery,
    MAX(delivery_time_minutes) AS slowest_delivery
FROM blinkit_orders
GROUP BY sales_channel
ORDER BY avg_delivery_time;

SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(
        SUM(quantity * unit_price) * 100.0 /
        (SELECT SUM(quantity * unit_price)
         FROM blinkit_orders),
        2
    ) AS revenue_contribution_percent
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue,
    ROUND(
        SUM(quantity * unit_price) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    ROUND(AVG(delivery_time_minutes), 2) AS average_delivery_time
FROM blinkit_orders



