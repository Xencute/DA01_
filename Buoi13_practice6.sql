---Baitap1---
with trung_job as
(select company_id, title
from job_listings
GROUP BY title, company_id
having COUNT(*)>1),

trung_jobdescription as
(select company_id, description
from job_listings
GROUP BY description, company_id
having COUNT(*)>1)

select COUNT(DISTINCT a.company_id) from job_listings as a inner join trung_job b on a.company_id=b.company_id
inner JOIN trung_jobdescription as c on a.company_id=c.company_id
