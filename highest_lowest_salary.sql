#highest and lowest salary
create table employee1 
(
emp_name varchar(10),
dep_id int,
salary int
);

insert into employee1 values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)

with min_max_salary as(
select dep_id,max(salary) as max_sal,min(salary) as min_sal
from employee1
group by dep_id
)

#join back to table to get employee name
select e.dep_id
#get employee name for max and min salary
,min(case when salary=min_sal then emp_name else null end) as min_sal_emp_name
,max(case when salary=max_sal then emp_name else null end) as max_sal_emp_name
from employee1 e
inner join min_max_salary s
on e.dep_id=s.dep_id
group by e.dep_id


