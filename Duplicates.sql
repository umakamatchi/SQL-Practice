#rank the duplicates
create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');
#output dup1,dup1,null,dup2,dup2
#get duplicates
with cte_duplicates as
(select id
from list
group by id 
having count(1) >1)
#create rank for dup1, dup2
,cte_rank as(
select *
,rank()over(order by id asc) as rn
from cte_duplicates)
#join with original table

select list.*,('DUP'+ cast(cr.rn as char(2))) as output
from list
left join cte_rank cr
on list.id=cr.id