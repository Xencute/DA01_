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

SELECT * FROM public.sales_dataset_rfm_prj
select ORDERDATE,
EXTRACT (MONTH FROM ORDERDATE), EXTRACT (YEAR FROM ORDERDATE), 
EXTRACT(DAY FROM ORDERDATE)
from public.sales_dataset_rfm_prj

UPDATE public.sales_dataset_rfm_prj
SET qtr_id=
