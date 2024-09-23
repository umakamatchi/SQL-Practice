#Write a query to print Total Salary for each Department
CREATE TABLE Dept(
id_deptname VARCHAR(20),
emp_name VARCHAR(25),
salary INT
);
INSERT INTO Dept(id_deptname, emp_name, salary) VALUES
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);
#seperate string dept name from numerical
#SUBSTRING_INDEX(string, delimiter, number)
#number-- The number of times to search for the delimiter. Can be both a positive or negative number.
#If it is a positive number, this function returns all to the left of the delimiter. If it is a negative number, this function returns all to the right of the delimiter.

select 
substring_index(id_deptname,'-',-1) as deptname,
sum(salary) as total_sal
from dept
group by deptname


