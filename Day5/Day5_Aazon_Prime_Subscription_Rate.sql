/*
create table Amazon_users
(
user_id integer,
name varchar(20),
join_date date
);
insert into Amazon_users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));
*/
Select * from Amazon_users
Select * from events;

WITH Total_userAcess_music AS (
    SELECT COUNT(DISTINCT au.user_id) AS Total_userAcess_music
    FROM Amazon_users au
    JOIN events e
        ON au.user_id = e.user_id
    WHERE e.type = 'Music'
),
Total_users AS (
    SELECT COUNT(DISTINCT user_id) AS Total_users
    FROM Amazon_users
),
use_who_buy_premium AS (
    SELECT COUNT(DISTINCT au.user_id) AS use_who_buy_premium
    FROM Amazon_users au
    JOIN events e
        ON au.user_id = e.user_id
    WHERE e.type = 'P'
      AND DATEDIFF(DAY, au.join_date, e.access_date) <= 30
)
SELECT
    tu.Total_users,ubp.use_who_buy_premium,tam.Total_userAcess_music,
    CAST(ubp.use_who_buy_premium AS FLOAT)
        / NULLIF(tam.Total_userAcess_music, 0) AS premium_ratio
FROM Total_users tu
CROSS JOIN Total_userAcess_music tam
CROSS JOIN use_who_buy_premium ubp;
