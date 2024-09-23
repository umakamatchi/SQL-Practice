-- DATASET
create table candidates1
(
    id      int,
    gender  varchar(1),
    age     int,
    party   varchar(20)
);
insert into candidates1 values(1,'M',55,'Democratic');
insert into candidates1 values(2,'M',51,'Democratic');
insert into candidates1 values(3,'F',62,'Democratic');
insert into candidates1 values(4,'M',60,'Republic');
insert into candidates1 values(5,'F',61,'Republic');
insert into candidates1 values(6,'F',58,'Republic');

create table results
(
    constituency_id     int,
    candidate_id        int,
    votes               int
);
insert into results values(1,1,847529);
insert into results values(1,4,283409);
insert into results values(2,2,293841);
insert into results values(2,5,394385);
insert into results values(3,3,429084);
insert into results values(3,6,303890);

-- output
-- Democratic 2
-- republic 1
#join 2 tables 
with cte as (
select *
,rank() over(partition by r.constituency_id order by r.votes desc) as rn
from candidates1 c
join results r on r.candidate_id=c.id)
select party,count(1) from cte
where rn=1
group by party
