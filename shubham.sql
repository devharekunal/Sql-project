
#find out city names who belong to particular state
select state,city,count(city)
from orders
group by state,city
order by state;

#find out highest customer from which State
select state, count(*) as customer_count
from orders
group by state
order by customer_count desc
limit 3;

#find out lowest customer from which city
select city, count(*) as customer_count
from orders
group by city
order by customer_count 
limit 3;

#find out the category who has max profit generate with its state

select * from
(select category, state, sum(profit) as 'total_profit',
row_number() over (partition by Category order by category,sum(profit) desc) as row_no
from orders 
inner join order_details
on orders.Order_ID=order_details.order_id
group by category, state) as x
where row_no<2;

#find out the category who has lowest profit generate with its city
select * from
             (select category, city, sum(profit) as 'total_profit',
             row_number() over (partition by Category order by category,sum(profit)) as row_no
             from orders 
             inner join order_details
			 on orders.Order_ID=order_details.order_id
			 group by category, city) as x
where row_no<2;

#find out the month who has the highest sale
select monthname(month_order_date), max(target) from sales
group by month_order_date;

#who is the customer who generate higher amount
select name,sum(amount*Quantity) as total_amount
from orders
join order_details
on orders.Order_ID=order_details.Order_ID
group by name
order by total_amount desc
limit 5;

#find out the target amount by category wise
create view target_amount as
select category, sum(target) as target
from sales
group by category
order by target desc;
