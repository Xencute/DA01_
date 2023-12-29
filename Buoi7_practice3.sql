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
