
---Baitap1---
with a as

(select * ,
case when order_date=customer_pref_delivery_date then 'immediate'
else 'scheduled'
end as delivery_type,
rank() over (partition by customer_id order by order_date asc)
from delivery) 

select round (cast((select count(*) from a 
where rank=1 and delivery_type='immediate') as decimal)*100.00/(select count(*) from a
where rank=1 ),2) as immediate_percentage

---baitap2---
with cte as (select *,lead(event_date) over (partition by player_id order by event_date),
lead(event_date) over (partition by player_id order by event_date)-event_date as interval 
from activity)

select round (cast (
    (select count(*) from cte where interval=1) as decimal)/(select count (distinct player_id) from cte),2)

as fraction

---Baitap3---
with student as
(select *, lead(student) over (order by id) , lag(student) over (order by id)
 from seat),

 student_chan as 
(select id, lag as student from student 
 where id%2=0),

student_le as 
(select id,
case when lead is not null then lead 
when lead is null then student 
end as student from student 
where id%2!=0)

select * from student_chan union select * from student_le 
order by id asc

---Baitap4---
with cte as (select visited_on, sum(amount)from customer
group by visited_on 
order by visited_on),

 b as (select visited_on, sum(sum)over (order by visited_on rows between 6 preceding and current row)as amount, round(avg(sum) over (order by visited_on rows between 6 preceding and current row),2)as average_amount, rank() over (order by visited_on)  from cte)

select visited_on, amount, average_amount from b
where rank >6

---Baitap5---
with cte as 
(select *, count( tiv_2015) over (partition by tiv_2015), count (
concat (lat,lon)) over (partition by concat (lat,lon)) as count_2
 from insurance)

 select round(
     cast(sum(tiv_2016)as decimal),2) as tiv_2016 from cte
 where count !=1 and count_2=1
---Baitap6---
    with a as (select *, dense_rank()over (partition by departmentid order by salary desc)as rank from employee) 

select a.name as employee, a.salary, b.name as department from a left join department b on a.departmentid=b.id
where rank in(1,2,3)
---Baitap7---
with cte as (select *, sum(weight) over (order by turn) from queue
order by turn),

b as
(select person_name, row_number ()over(order by turn desc) from cte 
where sum <=1000)

select person_name from b where row_number=1

---Baitap8---
with cte as

(select max(change_date), product_id from products
where change_date <='2019-08-16'
group by product_id),

b as 
(select product_id, new_price as price from products 
where (change_date, product_id) in (select max(change_date), product_id from products
where change_date <='2019-08-16'
group by product_id)),

c as
(select product_id, 10 as price from products
where change_date >'2019-08-16' and product_id not in (select product_id from cte))

select * from c union select * from b
