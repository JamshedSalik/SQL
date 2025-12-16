/*
create table tbl_orders
(
order_id int,
customer_id int,
product_id int,
);

insert into tbl_orders(order_id,customer_id,product_id) VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table tbl_products (
id int,
name varchar(10)
);
insert into tbl_products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');
*/

Select * from tbl_orders;
Select * from tbl_products;

Select concat(tp.name,' ',tp1.name) as pair, count(*) as purchase_frequency
from tbl_orders tos
inner JOIN tbl_orders tos1
ON tos.order_id = tos1.order_id and  tos.customer_id = tos1.customer_id and tos.product_id < tos1.product_id 
join tbl_products tp
on tos.product_id = tp.id 
join tbl_products tp1
on tos1.product_id = tp1.id
group by concat(tp.name ,' ',tp1.name);
