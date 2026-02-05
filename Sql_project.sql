#Retrieve the total number of orders placeorder_details_idd.
SELECT 
    COUNT(*) AS total_orders
FROM
    orders;
#Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS Total_revenue
FROM
    orders_details
        JOIN
    pizzas ON orders_details.pizza_id = pizzas.pizza_id;

#Identify the highest-priced pizza
SELECT 
    MAX(price)
FROM
    pizzas;

#Identify the most common pizza size ordered.

SELECT 
    pizzas.size, COUNT(orders_details.quantity)
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(orders_details.quantity) DESC
LIMIT 1; 

#List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_type1.name, COUNT(orders_details.quantity)
FROM
    pizza_type1
        JOIN
    pizzas ON pizza_type1.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizza_type1.name
ORDER BY COUNT(orders_details.quantity) DESC
LIMIT 5;

#Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_type1.category, COUNT(orders_details.quantity)
FROM
    pizza_type1
        JOIN
    pizzas ON pizza_type1.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_type1.category
ORDER BY COUNT(orders_details.quantity) DESC; 

#Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_type1
GROUP BY category;

#Group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    AVG(Total_quantity)
FROM
    (SELECT 
        orders.order_date,
            SUM(orders_details.quantity) AS Total_quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
#Determine the top 3 most ordered pizza types based on revenue
SELECT 
    pizza_type1.name,
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS revenue
FROM
    pizza_type1
        JOIN
    pizzas ON pizza_type1.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizza_type1.name
ORDER BY revenue DESC
LIMIT 3;

#Calculate the percentage contribution of each pizza type to total revenue.

select t.category, round(t.revenue * 100/ sum(t.revenue) over (),2) as Total_percent
from(
select pizza_type1.category, round(sum(orders_details.quantity *pizzas.price),2) as revenue
from pizza_type1 join pizzas on pizza_type1.pizza_type_id = pizzas.pizza_type_id
join orders_details on pizzas.pizza_id =orders_details.pizza_id
group by pizza_type1.category) as t
order by revenue desc;

#Analyze the cumulative revenue generated over time.
SELECT
    order_date,
   
    round(SUM(revenue) OVER (ORDER BY order_date),2) AS cum_revenue
FROM (
    SELECT
        o.order_date,
        SUM(od.quantity * p.price) AS revenue
    FROM orders_details od
    JOIN orders o 
        ON od.order_id = o.order_id
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    GROUP BY o.order_date
) AS sales
ORDER BY order_date;

#Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT
    category,
    pizza_name,
    revenue
FROM (
    SELECT
        pt.category,
        pt.name AS pizza_name,
        SUM(od.quantity * p.price) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY pt.category
            ORDER BY SUM(od.quantity * p.price) DESC
        ) AS rn
    FROM pizza_type1 pt
    JOIN pizzas p
        ON pt.pizza_type_id = p.pizza_type_id
    JOIN orders_details od
        ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name
) AS ranked
WHERE rn <= 3
ORDER BY category, revenue DESC;
    

