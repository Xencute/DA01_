---BAITAP1 ---
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

---BAITAP2---
with a as (select *, RANK()over(PARTITION BY card_name order by issue_year asc, issue_month asc)
FROM monthly_cards_issued)

select card_name,issued_amount from a 
where rank=1
order by issued_amount desc
