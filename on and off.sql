create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');
#output---login/logout/count when status is on
#groupin on and off as 1
#new group start after off---on coming after off
#use lag function to check the status of previous row

with grouped_sum as(
select *
,sum(case when status='on'and prev_status='off'then 1 else 0 end)over(order by event_time asc) as running_sum
from
(select *
,lag(status,1,status) over(order by event_time asc) as prev_status
from event_status)A)

select min(event_time) as login,max(event_time) as logout,count(1)-1 as on_count
from grouped_sum
group by running_sum