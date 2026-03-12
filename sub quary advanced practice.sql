--1. Find employees whose salary is greater than the average salary of all employees.
--Hint:
--Use a subquery with AVG(salary).
select*
from employees 
where salary>(select avg(salary) as average_salary
              from employees)

---2. Find employees who work in the same department as 'Steven King'.
---Hint:
---First find department_id of Steven King using a subquery.
select*from employees
select*from departments
select*
from employees
where department_id=(select department_id
                     from employees
					 where first_name='steven' and last_name='king')

---3. Display employees whose salary is greater than the salary of 'Neena Kochhar'.
---Hint:
---Subquery should return Neena's salary.
select* 
from employees
where salary>(select salary
              from employees
              where first_name='neena' and last_name='kochhar')

---4. Find employees who work in the IT department.
---Hint:
---Subquery should return department_id where department_name = 'IT'.
select*
from employees
where department_id=(select department_id
                     from departments
					 where department_name='IT')

---5. Display employees whose salary is less than the company average salary.
---Hint:
---Use AVG(salary) in the subquery.
select*
from employees
where salary<(select avg(salary)
              from employees)


---Medium Level
---
---6. Find employees who work in departments located in 'United States'.
---Hint:
---Use nested subqueries through countries → locations → departments → employees.
select*
from employees
where department_id in(select department_id
                     from departments
					 where location_id in(select location_id
					                    from locations
										where country_id in(select country_id
										                    from countries
													        where country_name='india')))

---7. Display employees whose job is the same as 'Lex De Haan'.
---Hint:
---Subquery should return job_id.
select*from employees
select *
from employees
where job_id=(select job_id
              from employees
			  where first_name='lex' and last_name='de haan')
              
---8. Find employees who work in departments that have more than 5 employees.
---Hint:
---Use GROUP BY department_id and HAVING COUNT(*) > 5 inside subquery.
select*
from employees
where department_id in(select department_id
                     from employees
					 group by department_id
					 having count(employee_id)>5)

---9. Find employees whose salary is greater than the average salary of their department.
---Hint:
---Use a correlated subquery comparing department_id.
select *
from employees  e
where salary>(select avg(salary)
              from employees e2
			  where e.department_id=e2.department_id)

---10. Find employees who work in the same city as employee 'Bruce Ernst'.
---Hint:
---Use nested subqueries involving locations.
select* from employees
select* from departments
select* from locations

select *
from employees
where  department_id in(select department_id 
                       from departments
					   where location_id in(select location_id
					                        from locations
											where location_id=1400)) 

---Advanced Level
---
---11. Find employees whose salary is the highest in their department.
---Hint:
---Use MAX(salary) with a correlated subquery.
select*
from employees e
where salary=(select max(salary)
              from employees e2
			  where e.department_id=e2.department_id)

---12. Find departments that do not have any employees.
---Hint:
---Use NOT IN or NOT EXISTS.
select department_id
from employees
where  not exists(select department_id
                  from employees
				  where employee_id is not null)

---3. Find employees who earn more than all employees in department 50.
---int:
---se > ALL.

select*
from employees
where salary>(select salary
              from employees
			  where department_id=50)

---14. Find employees who earn more than their manager.
---Hint:
---Compare employee salary with manager salary using a subquery.
select*
from employees e
where e.salary > (select m.salary
              from employees m
			  where e.manager_id=m.employee_id)
			  
---15. Find departments whose average salary is greater than the overall company average salary.
---Hint:
---Use HAVING with a subquery.

select department_id,
       avg(salary)as department_avg_sal
from employees
group by department_id
having avg(salary)>(select avg(salary)
                    from employees)  

	   






---Interview Level
---
---16. Find the second highest salary using a subquery.
---Hint:
---Use MAX(salary) where salary is less than the maximum salary.
select max(salary)
from employees e
where salary<(select max(salary)
              from employees e2)
			 
---17. Find employees whose salary is above the average salary of their job role.
---Hint:
---Compare salary with AVG(salary) grouped by job_id.
select *
from employees e
where salary>(select avg(salary)
              from employees e2
			  where e.job_id=e2.job_id)

---18. Find employees who work in departments located in the region 'Europe'.
---Hint:
---Use nested subqueries through regions → countries → locations → departments → employees.
select *
from employees
where department_id in(select department_id
                       from departments
					   where location_id in(select location_id 
					                        from locations
											where country_id in(select country_id
											                    from countries
																where region_id in(select region_id
																                   from regions
																				   where region_name='europe'))))


---9. Find employees whose salary is higher than the average salary of managers.
---int:
---anagers usually have job_id containing MAN.
select*
from employees e
where salary>(select avg(salary)
              from employees m
			  where job_id like '%MAN%')

---20. Find departments that have at least one employee earning more than 10000.
---Hint:
---Use EXISTS with a correlated subquery

select department_id,
       count(*)
from employees
group by department_id
having count(*)>10000



