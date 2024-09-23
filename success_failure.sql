
create table tasks (
date_value date,
state varchar(10)
);
insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')
#output--- start_date/end_date/state
#date continuous for sucess group together
#get row_no based on state sucess or failure
#if the date are continuous and subtract the row_no to get grouped_dates
#success fall to one group date
#get day and subtract with row_no from date_value
#The DATE_ADD() function adds a time/date interval to a date and then returns the date.
#DATE_ADD(date, INTERVAL value addunit)
with date_state as(
select *
,row_number()over(partition by state order by date_value) as row_no
#,date_add(date_value,INTERVAL -1 day)as gr1
#success comes to one group
,date_add(date_value,INTERVAL -1*cast(row_number()over(partition by state order by date_value) as signed) day)as grouped_date
from tasks)
select min(date_value) as start_date,max(date_value) as end_date,state
from date_state
group by grouped_date,state
order by start_date ;

