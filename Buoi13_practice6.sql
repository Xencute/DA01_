---Baitap1---
with duplicate_listing as

(select company_id from job_listings
group by company_id, title, description
having count(*)>1)

select COUNT(*) from duplicate_listing


---Baitap2---
