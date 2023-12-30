---Baitap1---
select 
sum(case when device_type ='laptop'then 1
else 0 
end) as laptop_reviews,
sum(case when device_type in ('tablet','phone') then 1
else 0 
end)as mobile_views
from viewership
----Baitap2----
select x,y,z,
case 
when abs(x-y)<z and z<x+y then 'Yes'
else 'No'
end as triangle
 from triangle
---Baitap3---
select 
round(
CAST(COUNT(call_id) as decimal)*100/COUNT(*),1)
from callers
WHERE call_category is NULL or call_category='n/a'
---Baitap4---
select name
from customer
where 
coalesce(referee_id,0)!=2
---Baitap5---
select survived,
sum(case when pclass=1 then 1
else 0
end) as first_class,
sum(case when pclass=2 then 1
else 0
end) as second_class,
sum(case when pclass=3 then 1
else 0
end) as third_class
from titanic
group by survived
