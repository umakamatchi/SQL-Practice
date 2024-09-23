#get consecutive seats are empty
create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');
#using lead and lag
# current, previous and next row is empty
#check 3 condn---1.previous 2 rows and current row,2. prev 1 row and next 2(lead),
with lag_lead as (
select bms.*,
lag(is_empty,1)over (order by seat_no) as prev_1
,lag(is_empty,2)over (order by seat_no) as prev_2
,lead(is_empty,1)over (order by seat_no) as next_1
,lead(is_empty,2)over (order by seat_no) as next_2
from bms)
select * from lag_lead
where is_empty='Y'and prev_1='Y'and prev_2='Y'
or(is_empty='Y'and prev_1='Y'and next_1='Y')
or(is_empty='Y'and next_1='Y'and next_2='Y')
order by seat_no
#advance aggregation---using rows between and sum(case when is empty) 
#method-2
with agg_lead_lag as (
select bms.*,
#checking for prev 2 and current row
sum(case when is_empty='Y' then 1 else 0 end )over (order by seat_no rows between 2 preceding and current row) as prev_2
#checking for prev1, and next_1
,sum(case when is_empty='Y' then 1 else 0 end )over (order by seat_no rows between 1 preceding and 1 following) as prev_next_1
,sum(case when is_empty='Y' then 1 else 0 end )over (order by seat_no rows between current row and 2 following) as prev_next
from bms)
select *
from agg_lead_lag 
where prev_2=3 or prev_next_1=3 or prev_next=3
#method-3
