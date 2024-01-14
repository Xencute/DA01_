with a as 

(SELECT extract(year from transaction_date) as year,product_id,SUM(spend) over (partition by product_id, 
date(transaction_date) order by date(transaction_date)) as curr_year_spend	
FROM user_transactions)

select *,

lag(curr_year_spend) over (partition by product_id order by year) as prev_year_spend, 
ROUND(
(curr_year_spend-lag(curr_year_spend) over (partition by product_id order by year))*100.00/(lag(curr_year_spend) over (partition by product_id order by year))
,2)
from a
