---Baitap1---
with duplicate_listing as

(select company_id from job_listings
group by company_id, title, description
having count(*)>1)

select COUNT(*) from duplicate_listing


---Baitap2---
  chưa học rank, row

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



----Baitap8---
select customer_id from customer
group by customer_id
having count(distinct product_key) = (select count(*) from product)

---Baitap9---
Select a.employee_id from employees a right join (select employee_id, manager_id from employees
where salary<30000 and manager_id is not null) b
on a.employee_id=b.manager_id
where a.employee_id is not null
order by employee_id

---Baitap10 - sailink ??? --- 
Select a.employee_id from employees a right join (select employee_id, manager_id from employees
where salary<30000 and manager_id is not null) b
on a.employee_id=b.manager_id
where a.employee_id is not null
order by employee_id

---Baitap11---
select * from (select c.name as results from users c join (select user_id,count(distinct movie_id) as count from movierating
group by user_id) d
on c.user_id = d.user_id
order by d.count desc, c.name
limit 1) UNION 
(select a.title from movies a join (select movie_id,avg(rating) as avg from movierating
where extract(year from created_at)=2020 and extract(month from created_at)=02
group by movie_id) b 
on a.movie_id=b.movie_id
order by b.avg desc, a.title asc
limit 1)

---Baitap12---
with a as (select count(requester_id) as tongchap_nhan,accepter_id as id from requestaccepted
group by accepter_id),

b as (select requester_id as id, count(accepter_id) as tongloi_gui from requestaccepted
group by requester_id)

select a.id, coalesce(a.tongchap_nhan,0)+ coalesce(b.tongloi_gui,0) as num from a full join b on a.id=b.id
order by coalesce(a.tongchap_nhan,0)+ coalesce(b.tongloi_gui,0) desc
limit 1
