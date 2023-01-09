-- create table employees
create table employees (
name varchar2(30),
department varchar2(30),
salary number);

-- populate table employees
insert into employees(name, department, salary) values('Kent', 'DC', 4200);
insert into employees(name, department, salary) values('Wayne', 'DC', 8400);
insert into employees(name, department, salary) values('Prince', 'DC', 5600);

-- user defined records
set serveroutput on;
declare
  type t_employees is record (name varchar2(30), department varchar2(30), salary number); 
  employee t_employees;
begin
  employee.name := 'Quinn';
  employee.department := 'DC';
  employee.salary := 2500;
  dbms_output.put_line(employee.name);
  dbms_output.put_line(employee.department);
  dbms_output.put_line(employee.salary);
  insert into employees values employee;
end;

declare
  type t_employees is record (name varchar2(30), department varchar2(30), salary number); 
  employee t_employees;
begin
  select * into employee from employees where name = 'Quinn';
  dbms_output.put_line(employee.name);
  dbms_output.put_line(employee.department);
  dbms_output.put_line(employee.salary);
end;

-- table based records
declare
  employee employees%rowtype;
begin
  select * into employee from employees where name = 'Wayne'; 
  dbms_output.put_line(employee.name);
  dbms_output.put_line(employee.department);
  dbms_output.put_line(employee.salary);
  employee.salary := 8800;
  update employees set row = employee where name = employee.name;
end;

select * from employees where name = 'Wayne'; 

-- cursor beased records
declare
  cursor c_employees is select * from employees;
  employee c_employees%rowtype;
begin
  open c_employees;
  loop
    fetch c_employees into employee;
    exit when c_employees%notfound;
    dbms_output.put_line(employee.name);
  end loop;
end;

-- collections of records
declare
  type t_employees is table of employees%rowtype;
  employee_set t_employees;
begin
  select * bulk collect into employee_set from employees where name in ('Prince', 'Quinn'); 
  for i in employee_set.first..employee_set.last loop
    dbms_output.put_line(employee_set(i).name);
  end loop;
end;
