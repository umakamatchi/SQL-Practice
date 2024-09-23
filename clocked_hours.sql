create table clocked_hour(

empd_id int,

swipe time,

flag char

);
INSERT INTO clocked_hour values

(11114,'08:30','I'),

(11114,'10:30','O'),

(11114,'11:30','I'),

(11114,'15:30','O'),

(11115,'09:30','I'),

(11115,'17:30','O');
## output employee_id/ total_no_clocked_hours----sum(clocked in-clocked out)
#create row_no to get in and out by employee_id and flag then order by swipe
with cte1 as 
(select *,
row_number() over(partition by empd_id,flag order by swipe) as rn
from clocked_hour),
cte2 as(
select empd_id,rn,min(swipe) as swipe_in, max(swipe) as swipe_out
,timestampdiff(hour,min(swipe),max(swipe)) as clocked_hours
from cte1
group by empd_id,rn)

select empd_id,sum(clocked_hours) as clocked_hours
from cte2
group  by empd_id

##every 2 rows is one transactions,using swipe alone punch in and out
##using lead function in the same step punch in and out
with cte3 as
(
select *,
lead(swipe,1) over(partition by empd_id order by swipe) as swipe_time
from clocked_hour
)
select empd_id,
sum(timestampdiff(hour,swipe,swipe_time))as clocked_hours
from cte3
where flag='I'
group by empd_id


