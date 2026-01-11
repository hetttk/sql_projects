--------pr 1 data diggerrr!!!!!--------



---creating database data digger--
CREATE database datadigger;
USE database datadigger;

----CREATING TABLE CUSTOMERS-----
CREATE TABLE customers(
    customer_id integer primary key AUTO_INCREMENT NOT NULL,
    customer_name varchar(50) NOT NULL,
    customer_email varchar(60) NOT NULL,
    customer_address varchar(150) NOT NULL
);


--inserting values into customers--
insert into customers(customer_id,customer_name,customer_email,customer_address)
values
('het','het5@gmail.com','surat'),
('alice','fresh5@gmail.com','palsana'),
('tirth','chitte067@gmail.com','ahemdabad'),
('dholu','kaliya@0009@gmail.com','mehsana'),
('bholu','kirmada5@gmail.com','dholakpur');

---- customer queries---
SELECT * FROM customers;
-------------------
update customers
set customer_address ="hyderabad"
where customer_id= 1;
--------------------------
delete customers
where customer_id=5;
--------------
select * from customers
where name = 'alice';


---creating table order---
create table orders(
    order_id integer primary key AUTO_INCREMENT,
    customer_id integer,
    order_date DATE,
    total_amount decimal(10,2),
    foreign key (customer_id) REFERENCES customers(customer_id)
);

---inserting values in orders table----
insert into orders(order_id,customer_id,order_date,total_amount)
values
(1, '2025-12-15', 2500),
(2, '2025-4-20', 1800),
(3, '2026-01-01', 3200),
(1, '2026-01-05', 1500),
(4, '2026-01-07', 4200);

---order queries---
SELECT* FROM customers orders where customer_id = 1;
-----------------
update customers
where order_id=1;
set total_amount=5000;
-------------------
delete from orders
where order_id =1;
------------
select date from orders where order_date>30 day;
--------------
select MAX(total_amount) as highest,
select MIN(total_amount) as lowest,
select AVG(total_amount) as average
from orders;


----creating table products----
create table products(
    product_id integer primary key AUTO_INCREMENT,
    product_name varchar(50) NOT NULL,
    price decimal(10,2),
    stock integer
);

-----inserting values into table products-----
insert into products(product_id,product_name,price,stock)
values
('Laptop', 55000, 10),
('Headphones', 1500, 25),
('Keyboard', 800, 0),
('Mouse', 600, 50),
('Monitor', 12000, 8);

----prooducts queries----
select * from products
order by price in desc;
--------------
update products
set price = 76000
where product_id =1;
------------
delete from products
where product_id=0;
-------------
select * from products
where price BETWEEN 500 and 2500;
--------------
select * from products
MAX(price) as expensive
MIN(price) as cheapest;
 
----CREATING ORDER DETAILS TABLE----
CREATE  TABLE ORDER_DETAILS(
    order_detail_id integer primary key AUTO_INCREMENT NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer,
    sub_total integer,
    foreign key(order_id) REFERENCES orders(order_id),
    foreign key(product_id) REFERENCES products(product_id)
);

----INSERT INTO ORDER DETAILS TABLE----v
INSERT INTO ORDER_DETAILS(order_id,product_id,quantity,sub_total)
values
(1, 1, 1, 55000),
(1, 2, 2, 3000),
(2, 4, 3, 1800),
(4, 5, 1, 12000),
(5, 1, 1, 55000);



---queries---
select * from ORDER_DETAILS
where order_id =1;
---------------
select
SUM(sub_total) as total_revenue
from ORDER_DETAILS;
--------------
select product_id, SUM(Quantity) AS TotalQuantity
from ORDER_DETAILS
group by  product_id
order by TotalQuantity DESC
LIMIT 3;
--------------
select COUNT(*) AS Times_sold
FROM ORDER_DETAILS
WHERE product_id = 1;





