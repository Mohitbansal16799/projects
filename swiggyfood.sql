create database swiggyfood;
# find coustomers who never orderd 
select users.name from swiggyfood.users where users.user_id not in ( select user_id from swiggyfood.orders);
# average price of food items 
select menu.f_id,avg(menu.price) from swiggyfood.menu group by f_id;
select food.f_name,avg(menu.price) from swiggyfood.menu join swiggyfood.food on menu.f_id = food.f_id group by menu.f_id;
# find top restaurant in no. of orders for a given month
select *,monthname(date) as month from swiggyfood.orders;
select restaurants.r_name,count(*) from swiggyfood.orders 
join swiggyfood.restaurants 
on orders.r_id = restaurants.r_id 
where monthname(date) like 'June' 
group by orders.r_id 
order by count(*) 
desc limit 1;
select restaurants.r_name,count(*) 
from swiggyfood.orders 
join swiggyfood.restaurants 
on orders.r_id = restaurants.r_id 
where monthname(date) like 'May' 
group by orders.r_id 
order by count(*) 
desc limit 1;
select restaurants.r_name,count(*) 
from swiggyfood.orders 
join swiggyfood.restaurants 
on orders.r_id = restaurants.r_id 
where monthname(date) like 'July' 
group by orders.r_id 
order by count(*) desc 
limit 1;
# resturants with monthly sales > 500
select restaurants.r_name,sum(orders.amount) as revenue from swiggyfood.orders 
join swiggyfood.restaurants 
on orders.r_id = restaurants.r_id 
where monthname(date) like 'june'
group by orders.r_id 
having sum(orders.amount)> 500;
select restaurants.r_name,sum(orders.amount) 
as revenue from swiggyfood.orders 
join swiggyfood.restaurants 
on orders.r_id = restaurants.r_id 
where monthname(date) 
like 'May'group by orders.r_id 
having sum(orders.amount)> 500;
select restaurants.r_name,sum(orders.amount) as revenue from swiggyfood.orders join swiggyfood.restaurants on orders.r_id = restaurants.r_id where monthname(date) like 'july'group by orders.r_id having sum(orders.amount)> 500;
#show all orders with orders detail for a particular coustomer in a particular day range 
select restaurants.r_name,order_details.f_id,orders.user_id, food.f_name, orders.order_id,orders.date 
from swiggyfood.orders 
join swiggyfood.restaurants on orders.r_id = restaurants.r_id 
join swiggyfood.order_details on orders.order_id = order_details.order_id 
join swiggyfood.menu on orders.r_id = menu.r_id 
join swiggyfood.food on menu.f_id = food.f_id 
where orders.user_id = (select user_id from swiggyfood.users where users.name like "ankit") and date > "2022-06-10" and date <"2022-07-10" ;
select restaurants.r_name,order_details.f_id,orders.user_id, food.f_name, orders.order_id,orders.date from swiggyfood.orders join swiggyfood.restaurants on orders.r_id = restaurants.r_id join swiggyfood.order_details on orders.order_id = order_details.order_id join swiggyfood.menu on orders.r_id = menu.r_id join swiggyfood.food on menu.f_id = food.f_id where orders.user_id = (select user_id from swiggyfood.users where users.name like "ankit") and date > "2022-05-10" and date <"2022-06-10" ;
select restaurants.r_name,order_details.f_id,orders.user_id, food.f_name, orders.order_id,orders.date from swiggyfood.orders join swiggyfood.restaurants on orders.r_id = restaurants.r_id join swiggyfood.order_details on orders.order_id = order_details.order_id join swiggyfood.menu on orders.r_id = menu.r_id join swiggyfood.food on menu.f_id = food.f_id where orders.user_id = (select user_id from swiggyfood.users where users.name like "ankit") and date > "2022-07-10" and date <"2022-08-10" ;
#find resturants with max repeated coustomer
select restaurants.r_name,count(*) as "loyalcoustomer" from 
         (select orders.user_id,orders.r_id,count(*) as visit from swiggyfood.orders 
          group by orders.r_id,orders.user_id 
          having count(*) > 1
)t join swiggyfood.restaurants on restaurants.r_id = t.r_id 
group by t.r_id 
order by loyalcoustomer 
desc limit 1;
#month over month revenue growth of swiggy
select month,(revenue-prev/prev)*100 from 
      (select t.month,t.revenue,lag(revenue,1) over (order by revenue ) as prev from  
                 (select monthname(date) as "month",sum(amount) as revenue from swiggyfood.orders 
                  group by month 
                  order by month(date)
                  )t)p;
#coustomers favourite food 
with temp as (select orders.user_id,order_details.f_id,count(*) as freq from swiggyfood.orders join swiggyfood.order_details on orders.order_id = order_details.order_id group by orders.user_id,order_details.f_id)
select users.name,food.f_name from temp t1 join swiggyfood.food on t1.f_id = food.f_id join swiggyfood.users on users.user_id = t1.user_id where t1.freq = (select max(freq) from temp t2 where t1.user_id = t2.user_id);

