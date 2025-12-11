/*
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);*/

-- Write an SQL Query to find the total number of users and the total amount spent using mobile only,desktop only and both mobile and desktop 
-- together for each date.



Select * from spending;

with cte as(
Select spend_date,user_id,max(platform) as platform,sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) = 1

union all 

Select spend_date,user_id,'both' as platform ,sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) = 2

union all 

Select   distinct spend_date,null as total_users,'both' as platforms, 0 as amount
from spending
)
Select spend_date,platform,sum(amount) as total_amount,count(distinct user_id) as total_users
from cte
group by spend_date,platform
order by  spend_date,platform desc

