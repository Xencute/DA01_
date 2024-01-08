---Baitap1---
with duplicate_listing as

(select company_id from job_listings
group by company_id, title, description
having count(*)>1)

select COUNT(*) from duplicate_listing


---Baitap2---

---Baitap3---
with member_over3calls as
(SELECT policy_holder_id, COUNT(case_id) FROM callers
group by policy_holder_id
having COUNT(case_id) >=3)
select count(*) from member_over3calls

---Baitap4----
with liked_page as
(select DISTINCT page_id from page_likes
GROUP BY page_id
having COUNT(page_id)>0)

select a.page_id from pages a left join liked_page b
on a.page_id=b.page_id
where b.page_id is null

---Baitap5---

with active_user as
(select user_id from user_actions
where event_type in ('sign-in','like','comment')
and (to_char(event_date,'mm-yyyy')='07-2022' or to_char(event_date,'mm-yyyy')='06-2022')
group by user_id
having COUNT( DISTINCT EXTRACT(month from event_date))  >1)

select 7 as month, count (*) from active_user

---Baitap6----
with a as
(select to_char(trans_date,'yyyy-mm') as month, country, count(id)as trans_count from transactions
group by to_char(trans_date,'yyyy-mm'), country),

b as (select to_char(trans_date,'yyyy-mm')as month, country, sum(amount)as trans_total_amount from transactions
group by to_char(trans_date,'yyyy-mm'), country),

c as 
(select to_char(trans_date,'yyyy-mm') as month, country, count(*)as approved_count from transactions
where state='approved'
group by to_char(trans_date,'yyyy-mm'), country),

d as 
(select to_char(trans_date,'yyyy-mm')as month, country, sum(amount) as approved_total_amount from transactions
where state='approved'
group by to_char(trans_date,'yyyy-mm'), country)


select a.month, a.country,a.trans_count, c.approved_count, b.trans_total_amount,d.approved_total_amount from a join b on (a.month=b.month and a.country=b.country)
join c on a.month=c.month and a.country=c.country
join d on a.month=d.month and a.country=d.country

---Baitap7---
with b as 
(select product_id,min(year) as first_year from sales
group by product_id)

select a.product_id,b.first_year,a.quantity,a.price from sales a join (select product_id,min(year) as first_year from sales
group by product_id) as b
on a.product_id=b.product_id and a.year=b.first_year
