create table covid1(city varchar(50),days date,cases int);

insert into covid1 values('DELHI','2022-01-01',100);
insert into covid1 values('DELHI','2022-01-02',200);
insert into covid1 values('DELHI','2022-01-03',300);

insert into covid1 values('MUMBAI','2022-01-01',100);
insert into covid1 values('MUMBAI','2022-01-02',100);
insert into covid1 values('MUMBAI','2022-01-03',300);

insert into covid1 values('CHENNAI','2022-01-01',100);
insert into covid1 values('CHENNAI','2022-01-02',200);
insert into covid1 values('CHENNAI','2022-01-03',150);

insert into covid1 values('BANGALORE','2022-01-01',100);
insert into covid1 values('BANGALORE','2022-01-02',300);
insert into covid1 values('BANGALORE','2022-01-03',200);
insert into covid1 values('BANGALORE','2022-01-04',400);

#delhi increasing continuously---giving rank 
#rank to days and cases
#find cities both ranks are same
with cte as
(select *
,rank()over(partition by city order by days asc) as rn_days
,rank()over(partition by city order by cases asc) as rn_cases
,cast(rank()over(partition by city order by days asc) as signed) - cast(rank()over(partition by city order by cases asc) as signed) as diff
from covid1)
select city
from cte 
group by city
having count(distinct diff)=1 and max(diff)=0

