---Bai tap 1----
select distinct city from station
where id%2=0
---Bai tap 2--- 
select
count(city)- count(distinct city)
from station
---Bai tap 3--- skip buoi sau
---Bai tap 4---
SELECT 
ROUND(SUM(ITEM_COUNT::DECIMAL * order_occurrences)/SUM(order_occurrences),1) as mean
FROM items_per_order;
--Bai tap 5---
SELECT candidate_id
FROM candidates
where skill in ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING count(skill) >=3
ORDER BY candidate_id
---Bai tap 6 --- skip buoi sau
---Bai tap 7---
SELECT card_name,
max(issued_amount)-min(issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by max(issued_amount)-min(issued_amount) DESC
---Bai tap 8---
SELECT manufacturer,
COUNT(drug) as failed_product,
abs(SUM(total_sales-cogs)) as total_loss
FROM pharmacy_sales
WHERE total_sales- cogs <0
GROUP BY manufacturer
ORDER BY total_loss desc
---Bai tap 9---
select id, movie, description, rating
from cinema
where description !='boring' and id%2!=0
order by rating desc
---Bai tap 10---
Select teacher_id,
count (distinct subject_id)
from teacher
group by teacher_id
---Bai tap 11---
select user_id,
count(follower_id) as tol_follower
from followers
group by user_id
order by user_id
---Bai tap 12---
select class
 from courses
 group by class
having count(student) >=5
