Create table candidates(
id int primary key,
positions varchar(10) not null,
salary int not null);
insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);
#running sum ---lowest salary of the senior , compare with the budget
#first hire the lowest salaried senior one with the budget of 50,000$
#to remove duplicate salary by considering unique id
#how many senior and junior

#running sum
with running_cte as
(select *,
sum(salary) over(partition by positions order by salary asc,id) as running_sal
from candidates
),
senior_cte as
(
select count(*) as seniors,sum(salary) as s_salary
from running_cte
where positions='senior' and running_sal<=50000
),
junior_cte as
(select count(*) as juniors
from running_cte
where positions='junior' and running_sal<=50000-(select s_salary from senior_cte)
)
select seniors, juniors
from senior_cte,junior_cte