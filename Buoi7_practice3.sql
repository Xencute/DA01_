---Baitap1---
select name
from students
where marks>75
order by  right(name,3), id
--- Baitap2---
select user_id,
(concat((Upper(left(name,1))),(lower(right(name,length(name)-1)))))as name
from users
---Baitap3---
SELECT manufacturer,
'$'||round(sum(total_sales)/1000000,0)||' million'
FROM pharmacy_sales
group by manufacturer
order by round(SUM(total_sales),0) desc, manufacturer
---Baitap4---
SELECT 
extract(month from submit_date) as mth,
product_id as product,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
group by product_id, extract(month from submit_date)
order by extract(month from submit_date), product_id
---Baitap5---
SELECT
sender_id, count(message_id)as message_count
FROM messages
WHERE TO_CHAR(sent_date,'mm-yyyy')='08-2022'
group by(sender_id)
ORDER BY count(message_id) desc
limit 2
---Bai tap 6---
select tweet_id
from tweets
where length(content)>15
---Bai tap7---
select 
activity_date as day,
count (distinct user_id) as active_users
from activity
group by activity_date
having activity_date BETWEEN '2019-06-27'AND '2019-07-27'

---Baitap8---
select 
count(id) as employee_number
from employees
where joining_date between '2022-01-01' and '2022-07-31'

---Baitap9---
select 
position('a'in first_name)
from worker
where first_name='Amitah'

---Baitap10---
select 
substring(title from position('2' in title) for 4)
from winemag_p2
where country='Macedonia'
