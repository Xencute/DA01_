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
