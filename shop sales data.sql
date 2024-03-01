create table if not exists sales(
invoice_id varchar(30) not null primary key,
breanch varchar(30) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float(6,4) not null,salessales
total decimal(12,4) not null,
date datetime not null,
time time not null,
payment_method varchar(20) not null,
cogs decimal(10,2)not null,
gross_margin_percentage float(11,9),
gross_income decimal(12,4) not null,
rating float(2,1)

);



-- rename of column 

alter table sales
change column breanch branch varchar(30);

-----------------------------------------------------------------------------------
------------------------- feature of adding new columns-------------------------------------------------
-- time _of_day

select time, 
( case 
when time between "00:00:00" and "12:00:00" then " MORNING" 
when time between "12:00:01" and "16:00:00" then " AFTER-NOON" 
else " EVENING"
end 
)AS time_of_date
from sales;


alter table sales add column time_of_day varchar(30);

update sales
set time_of_day =(
  case 
      when time between "00:00:00" and "12:00:00" then " MORNING" 
	when time between "12:00:01" and "16:00:00" then " AFTER-NOON" 
      else " EVENING"
end 
);
--------------------------------

-- day_name

select date,
DAYNAME(date)as day_name
from sales;

alter table sales add column day_name varchar(30);



update sales
set day_name =DAYNAME(date);

----------------------------------------

-- month_name

select date,
MONTHNAME(date)
from sales;

alter table sales add column month_name varchar(30);

update sales
set month_name =MONTHNAME(date);


---------------------------------
-------------------------- cities and branches ---------------------------
-- unique cities
select
     distinct city
from sales;

-- unique branch
select
     distinct branch
from sales;


select 
distinct city,branch
from sales;


-----------------------------------------
--------------- products ----------------

-- how many unique product line does data have -------

select 
count(distinct product_line)
from sales;

-- commom payment method ----

select 
payment_method,
count(payment_method) as cnt
from sales
group by payment_method
order by cnt desc;

--- most selling product ---------------

select
product_line,
count(product_line)as cnt
from sales
group by product_line
order by cnt desc;

------- total revenue by month -------------

select 
month_name as month,
sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;

----- city with largest revenue -------------

select branch, city,sum(total)as total_revenue
from sales
group by city,branch
order by total_revenue desc;


------------ branch which sold more product then avg product sold ---------------

select 
branch,
sum(quantity) as qty
from sales
group by branch
having sum(quantity)>(select avg(quantity) from  sales);


------------ common product from gender -------------

select gender,product_line,
count(gender) as total_cnt
from sales 
group by gender,product_line
order by total_cnt desc;


--------------- number of sales made in each time of day per week ---------------
select
time_of_day,
count(*)as total_sales
from sales
group by time_of_day
order by total_sales desc;


-----------------  everyday sales -------------------------
select
time_of_day,
count(*)as total_sales
from sales
where day_name="monday"
group by time_of_day
order by total_sales desc;


----------------------- 