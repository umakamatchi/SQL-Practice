create table job_position
(id  int,
title varchar(100),
groupss varchar(10),
levels varchar(10),     
payscale int, totalpost int );
insert into job_position values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_position values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_position values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

  create table job_employees ( id  int, 
                                                 name   varchar(100),     
                                                  position_id  int 
                                                );  
  insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
 insert into job_employees values (3, 'Michael Brown', 2);
 insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
 insert into job_employees values (8, 'Olivia Wilson', 3);
 insert into job_employees values (9, 'Daniel Martinez', 3);
 insert into job_employees values (10, 'Sophia Miller', 3)
#output needs according to the no of posts
#using recursive cte to create 15 columns by rank
#then create row_no for the employee table
#Then join with emoployee table with id and rank
with recursive cte as 
#create rank for position table
(select id,title,groupss,levels,payscale,totalpost,1 as rn from job_position
union all
select id,title,groupss,levels,payscale,totalpost,rn+1 from cte
where rn+1 <=totalpost
)
,emp as (select * ,row_number() over(partition by position_id order by id ) as rn
from job_employees as emp
)
select cte.*,coalesce(emp.name,'vacant') as name
from cte
left join emp 
on cte.rn=emp.rn and cte.id=emp.position_id
order by cte.id,cte.rn
