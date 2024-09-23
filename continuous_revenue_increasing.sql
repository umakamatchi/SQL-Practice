create table company_revenue 
(
company varchar(100),
year int,
revenue int
)
INSERT INTO company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);
#check on previous revenue value on company wise--lag function null for no previous value
#diff is positive is increasing
#select only count=sales_inc count
with cte as(
select *,
lag(revenue,1,0) over(partition by company order by year asc) as prev_rev
,revenue-lag(revenue,1,0) over(partition by company order by year asc) as rev_diff
#how many year 
,count(1) over(partition by company) as count
from company_revenue)
select company,count,count(1) as sales_inc
from cte
where rev_diff>0
group by company,count
having count=sales_inc