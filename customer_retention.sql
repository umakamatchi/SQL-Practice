create table transactions1(
order_id int,
cust_id int,
order_date date,
amount int
);

insert into transactions1 values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;
#retention ---customer who has consecutive order date for a month
#get month where  order date diff between jan and feb is 1---cust who continue to buy in jan and feb
#compare table by itself --use self join
select month(this_month.order_date) as month_date,count(distinct last_month.cust_id)
from transactions1 this_month
left join transactions1 last_month on this_month.cust_id=last_month.cust_id and 
datediff(last_month.order_date,this_month.order_date)=1
group by month(this_month.order_date)