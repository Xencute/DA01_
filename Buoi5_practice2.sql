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
