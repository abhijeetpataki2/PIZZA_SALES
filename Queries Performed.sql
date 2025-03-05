-- Basic:
-- Retrieve the total number of orders placed.

 select count(*) AS total_number from orders;
 
 -- Calculate the total revenue generated from pizza sales.(using join)
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
 
 
 -- Identify the highest-priced pizza.
 
 select max(price) AS highest_priced from
 pizzas;


-- Identify the most common pizza size ordered.

select quantity, count(order_details_id)
from order_details
group by quantity
 
 
 -- Identify the most common pizza size ordered.
 
 select pizzas.size, count(order_details.order_details_id) AS order_count
 from pizzas
 join order_details on pizzas.pizza_id = order_details.pizza_id
 group by pizzas.size
 order by order_count desc;
 
 
 
 -- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(order_details.quantity) AS most_ordered
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by most_ordered desc
limit 5;







-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,sum(order_details.quantity) AS total_quantity
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id =pizzas.pizza_id
group by pizza_types.category
order by total_quantity desc;





-- Determine the distribution of orders by hour of the day.


select hour(order_time) AS hour,count(order_id) As order_count from orders
group by hour(order_time);








-- Join relevant tables to find the category-wise distribution of pizzas.


select category, count(name) from pizza_types
group by category





-- Group the orders by date and calculate the average number of pizzas ordered per day.
 select round(avg (quantity),0) as Average  from
 (
 select orders.order_date, sum(order_details.quantity) as quantity
 from orders
 join order_details
 on orders.order_id=order_details.order_id
 group by orders.order_date) as order_quantity;
 
 
 
 
 
 
 
 -- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by revenue desc
limit 3;