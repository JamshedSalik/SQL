/*
create table user_detail (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50)
 );

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into user_detail values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 */

 Select * from orders;
 Select * from user_detail;
 Select * from items;

with cte as(
 Select  o.seller_id,o.order_id,o.order_date,o.item_id,o.buyer_id,i.item_brand,rank()over(partition by seller_id order by order_date asc) as rn
 from orders o
 join items i
 on o.item_id = i.item_id
 ), cte2 as(
	Select ud.user_id as seller_id,cte.item_brand,ud.favorite_brand,cte.rn,
		   case when item_brand=favorite_brand then 'Yes'
				Else 'No' END as second_favorite_brand 
 from cte
 Right join user_detail ud
 on ud.user_id = cte.seller_id and rn =2
 )
 Select seller_id,second_favorite_brand from cte2;
