1/ ---Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) ---

alter table public.sales_dataset_rfm_prj
alter column ordernumber type int using ordernumber::integer,
alter column quantityordered type int using quantityordered::integer,
alter column priceeach type float USING priceeach::double precision,
alter column orderlinenumber type int using orderlinenumber::integer,
alter column sales	type float USING sales::double precision,
alter column orderdate type date USING orderdate::date,
alter column msrp type int using msrp::integer
2/ --- check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE---
Mở properties/ Mục Columns / Switch on NOT NULL ? cho các mục kể trên

3/---Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME---

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN CONTACTLASTNAME VARCHAR 
ADD COLUMN CONTACTFIRSTNAME VARCHAR 
  
UPDATE public.sales_dataset_rfm_prj
SET CONTACTLASTNAME=LEFT(contactfullname, POSITION('-' in contactfullname)-1) ,
CONTACTFIRSTNAME= RIGHT(contactfullname, length(contactfullname)-POSITION('-' in contactfullname))	
  
---Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường---
UPDATE public.sales_dataset_rfm_prj
SET contactfirstname=upper(left(contactfirstname,1))||lower(right(contactfirstname, length(contactfirstname)-1)),
contactlastname=upper(left(contactlastname,1))||lower(right(contactlastname, length(contactlastname)-1))

4/ --- Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE --- 
ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN QTR_ID NUMERIC,
ADD COLUMN MONTH_ID NUMERIC ,
ADD COLUMN YEAR_ID NUMERIC 

UPDATE public.sales_dataset_rfm_prj
SET QTR_ID=EXTRACT(quarter FROM ORDERDATE),
MONTH_ID=EXTRACT (MONTH FROM ORDERDATE),
YEAR_ID=EXTRACT (YEAR FROM ORDERDATE)

5/---Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách) ( Không chạy câu lệnh trước khi bài được review)---

Cach 1: su dung percenquartile, tinh Q1,Q3,IQR, gia tri lon hon Max=Q3+1.5IQR hoac nho hon Min=Q1-1.5IQR thi loai

Select * from public.sales_dataset_rfm_prj
where quantityordered<
(select percentile_cont(0.25) within group (order by quantityordered)-1.5*(percentile_cont(0.75) within group (order by quantityordered)-percentile_cont(0.25) within group (order by quantityordered)) from public.sales_dataset_rfm_prj
) or quantityordered >(select percentile_cont(0.75) within group (order by quantityordered) +1.5*(percentile_cont(0.75) within group (order by quantityordered)-percentile_cont(0.25) within group (order by quantityordered))from public.sales_dataset_rfm_prj)

Cach 2: Quy doi qua z_score= (Gia tri quan sat- AVG)/STDDEV, neu ABS >2 or 3(tuy bai) thi la outlier
Select *, (quantityordered- (select avg(quantityordered)from public.sales_dataset_rfm_prj))/(select stddev(quantityordered) from public.sales_dataset_rfm_prj) as z_score
from public.sales_dataset_rfm_prj
where abs((quantityordered- (select avg(quantityordered)from public.sales_dataset_rfm_prj))/(select stddev(quantityordered) from public.sales_dataset_rfm_prj))>3

Xu ly ban ghi 2 cach 
Cach 1: update outlier = gtri trung binh 

UPDATE public.sales_dataset_rfm_prj
SET quantityordered=(select avg(quantityordered)from public.sales_dataset_rfm_prj)
where quantityordered in (Select quantityordered from public.sales_dataset_rfm_prj
where abs((quantityordered- (select avg(quantityordered)from public.sales_dataset_rfm_prj))/(select stddev(quantityordered) from public.sales_dataset_rfm_prj))>3
)

Cach 2: xoa outlier
Delete from public.sales_dataset_rfm_prj
where quantityordered in (Select quantityordered from public.sales_dataset_rfm_prj
where abs((quantityordered- (select avg(quantityordered)from public.sales_dataset_rfm_prj))/(select stddev(quantityordered) from public.sales_dataset_rfm_prj))>3
)
CREATE TABLE SALES_DATASET_RFM_PRJ_CLEAN  as (select * from public.sales_dataset_rfm_prj)

