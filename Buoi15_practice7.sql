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

---BAITAP3---
SELECT USER_ID, SPEND, TRANSACTION_DATE FROM 
(SELECT *, RANK() OVER (PARTITION BY USER_ID ORDER BY TRANSACTION_DATE ASC) FROM transactions) AS A
WHERE RANK =3

---BAITAP4---
SELECT DISTINCT TRANSACTION_DATE,USER_ID, COUNT(*) OVER (PARTITION BY USER_ID ORDER BY TRANSACTION_DATE ASC)
AS purchase_count

FROM (
SELECT *, RANK() OVER (PARTITION BY USER_ID ORDER BY TRANSACTION_DATE DESC) FROM user_transactions) AS A
WHERE RANK=1

---BAITAP5---
SELECT USER_ID,TWEET_DATE,

case 
when sec_pre is null and  pre is null then ROUND(cast(tweet_count as decimal),2)
when sec_pre is null and pre is not null then  ROUND(CAST((tweet_count+pre)AS DECIMAL)/2,2) 
else ROUND(CAST((tweet_count+pre+sec_pre)AS DECIMAL)/3,2) 
end AS rolling_avg_3d

FROM  (SELECT *, LAG(TWEET_COUNT) OVER (PARTITION BY USER_ID ORDER BY TWEET_DATE) AS PRE, 

LAG(TWEET_COUNT,2) OVER (PARTITION BY USER_ID ORDER BY TWEET_DATE) AS SEC_PRE
FROM tweets) AS A 

hoặc cách dưới
select user_id, tweet_date, ROUND(avg(tweet_count) over (partition by user_id order by tweet_date
rows BETWEEN 2 preceding and current row),2) as rolling_avg
from tweets


---BAITAP6---
with a as (SELECT *, lead(transaction_timestamp) over (PARTITION BY merchant_id, credit_card_id
, amount ORDER BY transaction_timestamp asc) as nexttransaction_timestamp,


lead(transaction_timestamp) over (PARTITION BY merchant_id, credit_card_id
, amount ORDER BY transaction_timestamp asc) - transaction_timestamp as interval 
FROM transactions)

select COUNT(*) from a
where extract(hour from interval) <1 and extract(minute from interval)<=10

---BAITAP7---
select category, product, total_spend from (with a as (select category, product, sum(spend) as total_spend  from product_spend
where extract(year from transaction_date)=2022
group by category, product)

select *, row_number() over (partition by category order by total_spend desc) from a) as b
where row_number in(1,2)


---BAITAP8---
SELECT * FROM (with X as (SELECT DISTINCT b.artist_id,c.artist_name, count(*) over (PARTITION BY b.artist_id ) as total
FROM global_song_rank A LEFT JOIN SONGS B 
ON a.song_id=b.song_id
left join artists c on b.artist_id=c.artist_id
where a.rank<=10 and b.song_id is not null)
select artist_name,dense_rank() over(order by total desc)as artist_rank
from x)AS Z
WHERE ARTIST_RANK BETWEEN 1 AND 5 
