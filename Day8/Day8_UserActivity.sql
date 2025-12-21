/*create table tbl_UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into tbl_UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');*/

Select * from tbl_UserActivity;
with cte as(
Select * , row_number()over(partition by username order by username) as activity_number,
        count(*)over(partition by username order by username) as total_activities
from tbl_UserActivity)
select * 
from cte
where (activity_number =2) or (total_activities=1 )


