use hr_analyst;
select * from hr_1;
select * from hr_2;
select count(*) from hr_1;
select count(*) from hr_2;

--  1. KPI - Average Attrition rate for all Departments

select a.Department, concat(format(avg(a.attrition_n)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_n from hr_1 ) as a
group by  a.department;

-- 2. KPI - Average Hourly rate of Male Research Scientist

select JobRole, format(avg(hourlyrate),2) as Average_HourlyRate,Gender
from hr_1
where upper(jobrole)= 'RESEARCH SCIENTIST' and upper(gender)='MALE'
group by jobrole,gender;

-- 3. KPI - Attrition rate Vs Monthly income stats

select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b. `employee id` = a.employeenumber
group by a.department;

--  4. KPI - Average working years for each Department

select a.department, format(avg(b.TotalWorkingYears),1) as Average_Working_Year
from hr_1 as a
inner join hr_2 as b on b.`Employee ID`=a.EmployeeNumber
group by a.department;

-- 5. KPI - Job Role Vs Work life balance
select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr_1 as a
inner join hr_2 as b on b.`Employee ID` = a.Employeenumber
group by a.jobrole;


-- 6. KPI - Attrition rate Vs Year since last promotion relation

select a.JobRole,concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.YearsSinceLastPromotion),2) as Average_YearsSinceLastPromotion
from ( select JobRole,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.`employee id` = a.employeenumber
group by a.JobRole;





