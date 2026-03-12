1️⃣ Display employee name and department name.

Tables: employees, departments

Hint:
Join using department_id.

select concat(e.first_name, ' ' ,e.last_name) as employee_name,
       d.department_name
from employees as e
join departments as d
on e.department_id=d.department_id


2️⃣ Show employee name and job title.

Tables: employees, jobs

select* from employees
select* from departments
select* from locations
select* from countries
select* from regions
select* from jobs
select*from dependents
Hint:
Join job_id.
select concat(e.first_name, ' ' ,e.last_name) as employee_name,
       j.job_title
from employees as e
join jobs as j
on e.job_id=j.job_id


3️⃣ Display employee name, department name, and salary.

Tables: employees, departments

Hint:
Simple INNER JOIN.
select concat(e.first_name, ' ' ,e.last_name) as employee_name,
       d.department_name,
	   e.salary
from employees as e
join departments as d
on e.department_id=d.department_id

4️⃣ Show employee name and city where their department is located.

Tables:
employees → departments → locations

Hint:
You need 2 joins.
select * from employees
select*from departments
select*from locations
 select concat(e.first_name, ' ' ,e.last_name) as employee_name,
        l.city
from employees as e
join departments as d 
on e.department_id=d.department_id
join locations as l
on d.location_id=l.location_id

5️⃣ Display department name and city.

Tables: departments, locations

Hint:
Join using location_id.
select*from departments
select*from locations

select d.department_name,
       l.city
from departments as d
join locations as l
on d.location_id=l.location_id
-----------------------------------------------------------------------------
🟡 Level 2 — Medium JOIN
6️⃣ Show employee name, job title, and salary.

Tables: employees, jobs

Hint:
Join on job_id.
select* from employees
select* from departments
select* from locations
select* from countries
select* from regions
select* from jobs
select*from dependents
select concat(e.first_name, ' ' ,e.last_name) as employee_name,
       j.job_title,
	   e.salary
from employees as e
join jobs as j
on e.job_id=j.job_id

7️⃣ Display employee name and their manager name.

Tables: employees (self join)

Hint:
Join employees table with itself using manager_id.

Alias example idea:

employees e
employees m
select concat(e.first_name,' ',e.last_name) as emplooyee_name,
       concat(m.first_name,' ',m.last_name) as manager_name
from employees as e
join employees as m
on e.manager_id=m.employee_id

8️⃣ Show employee name and country where they work.

Tables path

employees
→ departments
→ locations
→ countries

Hint:
You need 3 joins.
select concat(e.first_name,' ',e.last_name)as employee_name,
       c.country_name
from employees as e
join departments as d
on e.department_id=d.department_id
join locations as l
on d.location_id=l.location_id
join countries as c
on c.country_id=l.country_id
       
9️⃣ Display employee name, department name, and job title.

Tables:

employees
departments
jobs

Hint:
Two joins.
select* from employees
select* from departments
select * from jobs
select concat(e.first_name,' ',e.last_name)as employee_name,
       d.department_name,
	   j.job_title
from employees as e
join departments as d
on e.department_id=d.department_id
join jobs as j
on e.job_id=j.job_id

🔟 Show employee name and region they belong to.

Tables chain

employees
→ departments
→ locations
→ countries
→ regions

Hint:
This is 4 joins.

select concat(e.first_name,' ',e.last_name)as employee_name,
       r.region_name
from employees as e
join departments as d
on e.department_id=d.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on l.country_id=c.country_id
join regions as r
on r.region_id=c.region_id
-----------------------------------------------------------------
🟠 Level 3 — Hard JOIN (Interview Level)
11️⃣ Show employees who have dependents.

Tables:

employees
dependents

Hint:
Use INNER JOIN.
select*from employees
select*from dependents

select e.*
from employees as e
inner join dependents as d
on e.employee_id=d.employee_id

12️⃣ Show employees who do NOT have dependents.

Hint:
Use:

LEFT JOIN
WHERE dependents.employee_id IS NULL
select e.*,
       d.employee_id
from employees as e
left join dependents as d
on e.employee_id=d.employee_id
where d.employee_id is null

13️⃣ Display employee name and number of dependents.

Tables:

employees
dependents

---Hint:

---Use

---GROUP BY
---COUNT()
select*from employees
select* from dependents
select e.first_name,
       count(d.dependent_id) as dependents_count
from employees as e
join dependents as d
on e.employee_id=d.employee_id
group by e.first_name


14️⃣ Show department name and total employees.

Tables

departments
employees

Hint:

GROUP BY department_name
select * from employees
select* from departments
select d.department_name,
       count(e.first_name) as total_employees
from departments as d
left join employees as e
on d.department_id=e.department_id
group by d.department_name

15️⃣ Show employee name, manager name, department name.

Tables

employees e
employees m
departments d

Hint:

e.manager_id = m.employee_id
e.department_id = d.department_id
select concat(e.first_name,' ',e.last_name)as employee_name,
       concat(m.first_name,' ',m.last_name)as manager_name,
	   d.department_name
from employees as e
join employees as m
on e.manager_id=m.employee_id
join departments as d
on e.department_id=d.department_id
--------------------------------------------------------------------
🔴 Level 4 — Very Hard (Real Interview Style)
16️⃣ Display the department with the highest number of employees.

Hint

JOIN + GROUP BY
ORDER BY COUNT(*) DESC
select top 1  d.department_name,
       count(e.employee_id)as employee_count
from employees as e
join departments as d
on e.department_id=d.department_id
group by d.department_name
order by count(e.employee_id) desc

17️⃣ Show employees whose salary is greater than their manager.

Hint

Self join employees.

select e.*
from employees as e
join employees as m
on e.manager_id=m.employee_id
where e.salary>m.salary

18️⃣ Display region name and number of employees working in that region.

Tables chain

employees
→ departments
→ locations
→ countries
→ regions

Hint

GROUP BY region_name
select* from employees
select* from departments
select* from locations
select* from countries
select* from regions
select* from jobs
select*from dependents

select r.region_name,
       count(e.first_name)as no_of_employees
from employees as e
join departments as d
on e.department_id=d.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
join regions as r
on r.region_id=c.region_id
group by region_name

19️⃣ Show top 3 departments with highest average salary.

Hint

JOIN employees
GROUP BY department
AVG(salary)
select top 3  d.department_name,
       avg(e.salary) as average_salary
from employees as e
join departments as d
on e.department_id=d.department_id
group by d.department_name
order by avg(e.salary) desc

20️⃣ Display employee name, job title, department name, city, country, region.

Hint

You must join 6 tables.
select* from employees
select* from departments
select* from locations
select* from countries
select* from regions
select* from jobs
select*from dependents

select concat(e.first_name,' ',e.last_name)as employee_name,
       j.job_title,
       d.department_name,
	   l.city,
	   c.country_name,
	   r.region_name
from employees as e
join departments as d 
on e.department_id=d.department_id
join jobs as j
on j.job_id=e.job_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
join regions as r
on c.region_id=r.region_id


