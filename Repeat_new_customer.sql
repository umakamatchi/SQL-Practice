create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
# first date all 3 are new customer
#order_data,new_customer_count,repeat_cust_count
#3 0
#2 1
#1 2
#when was the customer order first time visted?
#then compare order date with firstvisit date if its not same its repeat else new
#join with original table on customer_id
with first_visit as
(select customer_id
,min(order_date) as first_visit
from customer_orders
group by customer_id)

,visit_flag as (select co.*,fv.first_visit
,case when co.order_date=fv.first_visit then 1 else 0 end as first_visit_flag
,case when co.order_date!=fv.first_visit then 1 else 0 end as repeat_visit_flag
,case when co.order_date=fv.first_visit then co.order_amount else 0 end as first_visit_order_amount
,case when co.order_date!=fv.first_visit then co.order_amount else 0 end as repeat_visit_order_amount
from customer_orders as co
inner join first_visit fv on co.customer_id=fv.customer_id
order by order_id)

select order_date,sum(first_visit_flag) as no_new_cust,
sum(repeat_visit_flag) as no_repeat_cust,sum(first_visit_order_amount) as new_cust_order_amount,
sum(repeat_visit_order_amount) as repeat_cust_order_amount
#non aggregated column should be grouped
from visit_flag
group by order_date