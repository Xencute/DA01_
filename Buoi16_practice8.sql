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
