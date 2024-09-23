#find the highest amount by each sales person
CREATE TABLE orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float  NOT NULL
);
INSERT INTO orders  VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into orders  VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO orders VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO orders VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into orders VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into orders  VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into orders VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);
#with using window function and cte
#with  amount_by_person as(
#select  order_number,salesperson_id, amount,#give rank according to amount to sales person 
#rank() over(partition by salesperson_id order by amount desc) as rn
#from orders)
#select  *
#from amount_by_person 
#where rn=1
#order by order_number 
#with out using cte, subquery
#using self join to compare values with in the table

#join on salesperson id and check if sales person order number 10 is compared with >= max(540 amd 2400)
#self join 2 tables a and b on salespersonid
select a.order_number,a.order_date,a.cust_id,a.salesperson_id,a.amount
from orders a
left join orders b on a.salesperson_id=b.salesperson_id
group by a.order_number,a.order_date,a.cust_id,a.salesperson_id,a.amount
having a.amount>=max(b.amount)
order by order_number
