---🟢 Beginner-Level (Simple Views)
---- Create a view to list employee names and their department names.
---Hint: Join Employees with Departments.
create  view emp_info as(
select concat(e.first_name,' ',e.last_name)as employee_name,
       d.department_name
from employees as e
join departments as d
on e.department_id=d.department_id)

select * from emp_info

---- Create a view to show employees working in the 'IT' department.
---Hint: Filter by department_name = 'IT'.
create view employee_it as(
select concat(e.first_name,' ',e.last_name)as employee_name,
       d.department_name
from employees as e
join departments as d
on e.department_id=d.department_id
where d.department_name='IT')

select * from employee_it

---- Create a view to display employee details along with their manager’s name.
---Hint: Self-join Employees on manager_id.
create view e_m_names as(
select e.*,
       concat(m.first_name,' ',m.last_name)as manager_name
from employees as e
left join employees as m
on e.manager_id=m.employee_id)

select * from e_m_names

---🟡 Intermediate-Level (Aggregations & Joins)
---- Create a view that shows the average salary per department.
---Hint: Use GROUP BY department_id.
create view avg_dept as(
select avg(salary)as average_salary_dapt
from employees
group by department_id)

select * from avg_dept

---- Create a view to list employees along with their country and region.
---Hint: Join Employees → Departments → Locations → Country → Region.

create  view emp_info_country_region as(
select e.*,
       c.country_name,
	   r.region_name
from employees as e
join departments as d
on e.department_id=d.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
join regions as r
on r.region_id=c.region_id)

select * from emp_info_country_region

---- Create a view that shows employees who earn more than the average salary of their department.
create view emp_avg_dept as(
select *
from employees e
where salary>(select avg(salary)
              from employees e2
			  where e.department_id=e2.department_id))

select* from emp_avg_dept

---- Create a view to display employees along with the number of dependents they have.
---Hint: Join Employees with Dependents and use COUNT.

create view emp_dependent as(
select e.employee_id,
       count(d.dependent_id)as no_of_dependents
from employees as e
join dependents as d
on e.employee_id=d.employee_id
group by e.employee_id,d.dependent_id)

select * from emp_dependent

---🔵 Advanced-Level (Stored Procedures)-
---Write a stored procedure to return all employees in a given department name (passed as a parameter).
create procedure employees_department_name
@department_name varchar(20)
as
begin
select  e.*,
        d.department_name
from employees as e
join departments as d
on e.department_id=d.department_id
where d.department_name=@department_name
end

exec employees_department_name 'IT'

---- Write a stored procedure to increase salaries of employees in a given region by 10%.
---Hint: Use UPDATE with joins.

create procedure emp_salary275
@region varchar(20)
as
begin 
update employees
set salary=salary*1.10

select e.*,
       r.region_name
from employees as e
join departments as d
on e.department_id=d.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
join regions as r
on r.region_id=c.region_id
where r.region_name=@region
end

exec emp_salary275 '7'

---- Write a stored procedure that accepts a country name and returns:
---- Number of employees in that country
---- Average salary
---- Highest-paid employee

create procedure emp_details
@country_name varchar(20)
as
begin
select count(e.employee_id)as employee_count,
       avg(e.salary)as average_salary,
	   max(e.salary)as highest_salary
from employees as e
join departments as d
on d.department_id=e.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
where c.country_name=@country_name;

select e.*
from employees as e
join departments as d
on d.department_id=e.department_id
join locations as l
on l.location_id=d.location_id
join countries as c
on c.country_id=l.country_id
where c.country_name=@country_name
order by e.salary desc;
end;

exec emp_details 'united states of america'

---- Write a stored procedure to insert a new employee and automatically assign them to a department based on location.
create procedure insret_info23
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @HireDate DATE,
    @JobID INT,
    @Salary DECIMAL(10,2),
    @ManagerID INT,
    @City NVARCHAR(50)

as 
begin 
 declare  @department_id int;

 select top 1 @department_id=d.department_id
 from departments as d
 join locations as l
 on d.location_id=l.location_id
 where l.city=@city;

 INSERT INTO Employees (
        first_name, last_name, email, phone_number, hire_date,
        job_id, salary, manager_id, department_id
    )
    VALUES (
        @FirstName, @LastName, @Email, @Phone, @HireDate,
        @JobID, @Salary, @ManagerID, @department_id
    );

SELECT 'Employee inserted successfully' AS Message,
           @department_id AS AssignedDepartment;
END;
EXEC Insret_info23 
    @FirstName = 'Alice',
    @LastName = 'Brown',
    @Email = 'alice.brown@sqltutorial.org',
    @Phone = '555.123.4567',
    @HireDate = '2026-03-11',
    @JobID = 9,
    @Salary = 7500,
    @ManagerID = 100,
    @City = 'Seattle';

---- Write a stored procedure to generate a report of employees hired in a given year, grouped by department.
CREATE PROCEDURE EmployeeHireReportByYear
    @HireYear INT
AS
BEGIN
    -- Report: employees hired in the given year, grouped by department
    SELECT 
        d.department_name,
        COUNT(e.employee_id) AS TotalEmployees,
        AVG(e.salary) AS AverageSalary,
        MIN(e.hire_date) AS FirstHireDate,
        MAX(e.hire_date) AS LastHireDate
    FROM Employees e
    INNER JOIN Departments d ON e.department_id = d.department_id
    WHERE YEAR(e.hire_date) = @HireYear
    GROUP BY d.department_name
    ORDER BY d.department_name;
END;

exec EmployeeHireReportByYear 1995

---⚫ Expert-Level (Dynamic SQL & Complex Logic)-
---Create a stored procedure that accepts a department name and dynamically builds a query to fetch employees with salaries above a given threshold.









---- Write a stored procedure to transfer an employee from one department to another, updating both department_id and manager_id accordingly.
---- Create a stored procedure that returns a hierarchical report of managers and their subordinates (recursive logic).
---👉 These questions progress from simple views (basic joins and filters) to stored procedures involving parameters, updates, and dynamic SQL. They’re perfect for practicing real-world HR database scenarios.Would you like me to write out the SQL code for a few of these (say, one beginner, one intermediate, and one advanced) so you can see how they’re structured?