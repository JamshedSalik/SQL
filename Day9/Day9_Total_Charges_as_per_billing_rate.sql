/*
create table tbl_billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);

insert into tbl_billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table tbl_HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into tbl_HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4);
*/

with bill_range as(
Select * , lead(dateadd(day,-1,bill_date),1,'9999-12-31') over(partition by emp_name order by bill_date asc) as bill_date_end
from tbl_billings)
Select *--br.emp_name, sum(br.bill_rate*th.bill_hrs) as total_bill_rate
from bill_range br
join tbl_HoursWorked th
on br.emp_name = th.emp_name and th.work_date between br.bill_date  and br.bill_date_end 
group by br.emp_name
order by br.emp_name;
