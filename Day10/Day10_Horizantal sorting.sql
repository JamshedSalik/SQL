/*
CREATE TABLE tbl_subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO tbl_subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);*/

Select * from tbl_subscriber;
with cte as(
Select case when sender<receiver then sender else receiver end as p1,
		case when sender>receiver then sender else receiver end as p2,
		sms_no
from tbl_subscriber)
Select p1,p2,sum(sms_no) as total_sms_exchange
from cte
group by  p1,p2


SELECT LEAST(sender,receiver) as p1,GREATEST(sender,receiver) as p2, sum(sms_no) as total_sms
FROM tbl_subscriber
group by LEAST(sender,receiver),GREATEST(sender,receiver);