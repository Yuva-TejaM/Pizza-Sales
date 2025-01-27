---  Retrieve the total no.of orders placed ??
select count(order_id) as Totalorders from pro.orders ;

---  Calculate the total revenue generated from pizza sales ??
Select sum(price*quantity)as TotalRevenue from pro.order_details as od
join pro.pizzas as p on od.pizza_id=p.pizza_id;

--- identify the highest priced pizza ??
select max(price) from pro.pizzas;

---  identify the most common size ordered ??
select count(quantity) ,size from pro.pizzas as p
join pro.order_details as od on od.pizza_id=p.pizza_id group by size order by size;

--- List the top 5 ordered pizza types along with quantity ?
select sum(quantity)as quan,name  from pro.order_details as od
join pro.pizzas as p on p.pizza_id=od.pizza_id
join pro.pizza_types as pt on pt.pizza_type_id=p.pizza_type_id group by name order by quan desc limit 5;

--- Total quantity of each pizza ordered ?
select sum(quantity),category from pro.order_details as od
join pro.pizzas as p on p.pizza_id=od.pizza_id
join pro.pizza_types as pt on pt.pizza_type_id=p.pizza_type_id group by category ;

--- Distribution of orders by an hour of the day ?
select count(order_id) as id,hour(time) from pro.orders group by hour(time);

--- Find the category wise distribution of pizzas  ?
select count(name),category from pro.pizza_types group by category;

--- Group the orders by date and cal avg  no.of pizzas ordered ?
select avg(quant) from(select date,avg(od.order_id),sum(quantity) as quant from pro.order_details as od
join pro.orders as o on o.order_id=od.order_id group by date) as order_quan;

--- Determine top 3 ordered pizzas type based on revenue ??
select sum(price*quantity) as revenue,name from  pro.order_details as od
join pro.pizzas as p on p.pizza_id=od.pizza_id
join pro.pizza_types as pt on pt.pizza_type_id=p.pizza_type_id group by name order by revenue desc limit 3;

--- Cal % contribution off each pizza to total revenue ??
select category,round(sum(price*quantity)/100) as TotalRevenue  from   pro.order_details as od
join pro.pizzas as p on p.pizza_id=od.pizza_id
join pro.pizza_types as pt on pt.pizza_type_id=p.pizza_type_id group by category;

--- Analyse cumulative revenue ??

select date ,sum(revenue) over(order by date) as cum_revenue from(select sum(price*quantity) as revenue,date  from pro.order_details as od
join pro.pizzas as p on p.pizza_id=od.pizza_id
join pro.pizza_types as pt on pt.pizza_type_id=p.pizza_type_id
join pro.orders as o on od.order_id=o.order_id group by date) as sales ;