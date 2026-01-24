
-- 1) inner join:
select c.customerid, c.firstname, c.lastname, o.orderid, o.totalamount
from customers c
join orders o
on c.customerid = o.customerid;


-- 2) left join: 
select c.customerid, c.firstname, c.lastname, o.orderid, o.totalamount
from customers c
left join orders o
on c.customerid = o.customerid;


-- 3) right join:
select c.customerid, c.firstname, c.lastname, o.orderid, o.totalamount
from customers c
right join orders o
on c.customerid = o.customerid;


-- 4) full outer join: 
select c.customerid, c.firstname, c.lastname, o.orderid, o.totalamount
from customers c
full join orders o
on c.customerid = o.customerid;


-- 5) subquery 
select distinct c.*
from customers c
join orders o on c.customerid = o.customerid
where o.totalamount > (select avg(totalamount) from orders);


-- 6) subquery
select *
from employees
where salary > (select avg(salary) from employees);


-- 7) extract year and month from orderdate
select orderid,
year(orderdate) as year,
month(orderdate) as month
from orders;


-- 8) calculate difference in days between order date and current date
select orderid,
datediff(current_date, orderdate) as days_difference
from orders;


-- 9) format orderdate to dd-mm-yyyy
select orderid,
date_format(orderdate,'%d-%m-%y') as formatted_date
from orders;


-- 10) concatenate firstname and lastname
select concat(firstname,' ',lastname) as fullname
from customers;


-- 11) replace john with jonathan in firstname
select replace(firstname,'john','jonathan') as new_name
from customers;


-- 12) convert firstname to uppercase and lastname to lowercase
select upper(firstname), lower(lastname)
from customers;


-- 13) trim extra spaces from email
select trim(email)
from customers;


-- 14) calculate running total of totalamount
select orderid, orderdate, totalamount,
sum(totalamount) over(order by orderdate) as running_total
from orders;


-- 15) rank orders based on totalamount
select orderid, totalamount,
rank() over(order by totalamount desc) as rank_no
from orders;


-- 16) assign discount based on totalamount
select orderid, totalamount,
case
  when totalamount > 1000 then '10% off'
  when totalamount > 500 then '5% off'
  else 'no discount'
end as discount
from orders;


-- 17) categorize employee salaries as high, medium, or low
select employeeid, firstname, salary,
case
  when salary >= 60000 then 'high'
  when salary between 40000 and 59999 then 'medium'
  else 'low'
end as salary_category
from employees;

