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
