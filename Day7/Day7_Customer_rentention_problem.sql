/*create table tbl_transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
insert into tbl_transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150);*/

Select * from tbl_transactions;

Select month(t1.order_date) as Month,count(distinct t2.cust_id) as repeated_customer
from tbl_transactions t1
left join tbl_transactions t2
on t1.cust_id = t2.cust_id and Datediff(month,t2.order_date,t1.order_date) =1
group by month(t1.order_date)



