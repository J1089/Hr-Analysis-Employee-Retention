create database hr;

use hr;

set autocommit = 0;
set SQL_SAFE_UPDATES = 0;
SET sql_mode='';

select * from hr_1;
select * from hr_2;

-- KPI 1
alter table hr_1 add column AttritionRate int not null;
update hr_1 set AttritionRate=
case
when attrition="Yes" then 1
when attrition="No" then 0
end;

create view KPI1 as
select department,concat(round(avg(attritionrate)*100,2),"%")
average_attrition_rate from hr_1
group by department;

select * from KPI1;

-- KPI 2
create view KPI2 as
select jobrole,gender,round(avg(hourlyrate),2) Avg_Hourly_Rate
from hr_1 
where jobrole="Research Scientist" and gender= "Male";

select * from KPI2;

-- KPI 3
create view KPI3 as
select h1.department,concat(round(avg(h1.attritionrate)*100,2),"%")
Average_Attrition_Rate,round(avg(h2.monthlyincome),2) Avg_Hourly_Rate
from hr_1 h1 
join hr_2 h2 on h2.`employee id`=h1.employeenumber
group by department
order by Average_Attrition_Rate asc;

select * from KPI3;

-- KPI 4
create view KPI4 as
select h1.department,round(avg(h2.totalworkingyears),2) Avg_working_years
from hr_1 h1 join hr_2 h2 on h2.`employee id`=h1.employeenumber
group by department;


select * from KPI4;

-- KPI 5
create view KPI5 as
select h1.jobrole,round(avg(h2.worklifebalance),2) Avg_Hourly_Rate
from hr_1 h1 join hr_2 h2 on h2.`employee id`=h1.employeenumber
group by jobrole;

select * from KPI5;

-- KPI 6
create view KPI6 as
select h1.jobrole,concat(round(avg(h1.attritionrate)*100,2),"%")
Average_Attrition_Rate,round(avg(h2.yearssincelastpromotion),2) Year_Since_Lastpromotion
from hr_1 h1 
join hr_2 h2 on h2.`employee id`=h1.employeenumber
group by jobrole;

select * from KPI6;

-- Views
select * from KPI1;
select * from KPI2;
select * from KPI3;
select * from KPI4;
select * from KPI5;
select * from KPI6;