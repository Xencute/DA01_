---Bai_tap_1---
select name from city
where population >120000 and countrycode='USA'
---Bai_tap_2---
select * from city
where countrycode = 'JPN'
---Bai_tap_3
select city, state from station
where lat_n =0 &long_w=0
---Bai_tap_4---
select distinct city from station
where city like 'a%' or city like'e%' or city like'i%'or city like'o%' or city like'u%'
---Bai_tap_5---
select distinct city from station
where city like '%a'or city like '%e' or city like '%i' or city like '%o'or city like '%u'
---Bai_tap_6---
select distinct city from station
where not (city like 'a%' or city like'e%' or city like'i%'or city like'o%' or city like'u%')
---Bai_tap_7---
select name from employee
order by name asc
---Bai_tap_8---
select name from Employee
where salary >2000 and months <10
order by employee_id asc
---Bai_tap_9---
select product_id from products
where low_fats ='Y' and recyclable='Y'
---Bai_tap_10---
select name from customer
where referee_id is null or referee_id !=2
---Bai_tap_11---
select name,population,area from world
where area >=3000000 or population >=25000000
---Bai_tap_12---
select distinct author_id as id from views
where author_id = viewer_id
order by author_id asc
---Bai_tap_13---
SELECT part, assembly_step FROM parts_assembly
where finish_date is null
---Bai_tap_14---
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary>=70000
---Bai_tap_15---
select advertising_channel from uber_advertising
where money_spent >100000 and year=2019 
---
