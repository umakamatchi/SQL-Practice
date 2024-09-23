CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);
INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

#select *
#from stores
#method 1 -aggregation
#total ---10-sum(quarters)=missing quarters

#seperate numericals from quarters column and then cast as int---signed
#extract string RIGHT(string, number_of_chars)

select store,cast(10-(sum(right(quarter,1)as signed))as q_no
from stores
group by store