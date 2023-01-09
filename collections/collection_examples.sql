
-- varrays
set serveroutput on;
declare
  type quarters is varray(4) of varchar2(2);
  quarter quarters;
begin
  quarter := quarters('Q1', 'Q2', 'Q3', 'Q4');
  for i in 1..4 loop
    dbms_output.put_line(quarter(i));
  end loop;
end;

-- nested tables
set serveroutput on;
declare
  type employees is table of varchar2(30);
  employee employees;
begin
  employee := employees('Kent', 'Wayne', 'Allen', 'Prince');
  for i in 1..4 loop
    dbms_output.put_line(employee(i));
  end loop;
end;

-- C5 associative arrays
set serveroutput on;
declare
  type salaries is table of number index by varchar2(30);
  salary salaries;
begin
  salary('Allen') := 3700;
  salary('Kent') := 4200;
  salary('Prince') := 5600;
  salary('Wayne') := 8400;
  dbms_output.put_line(salary('Allen'));
  dbms_output.put_line(salary('Kent'));
  dbms_output.put_line(salary('Prince'));
  dbms_output.put_line(salary('Wayne'));
end;

-- varrays methods
set serveroutput on;
declare
  type quarters is varray(4) of varchar2(2);
  quarter quarters;
  limit integer;
  cnt integer;
begin
  quarter := quarters('Q1', 'Q2', 'Q3', 'Q4');
  limit := quarter.limit;
  dbms_output.put_line('Collection limit: ' || limit);
  cnt := quarter.count;
  dbms_output.put_line('Collection count: ' || cnt);
  for i in 1..cnt loop
    dbms_output.put_line('Element ' || i || ': ' || quarter(i));
  end loop;
  quarter.trim;
  dbms_output.put_line('Trimmed last element');
  cnt := quarter.count;
  for i in 1..cnt loop
    dbms_output.put_line('Element ' || i || ': ' || quarter(i));
  end loop;
  quarter.extend;
  quarter(4) := 'Q4';
  dbms_output.put_line('Extended with one element with value Q4');
  cnt := quarter.count;
  for i in 1..cnt loop
    dbms_output.put_line('Element ' || i || ': ' || quarter(i));
  end loop;
end;

-- nested tables methods
set serveroutput on;
declare
  type employees is table of varchar2(30);
  employee employees;
  first integer;
  last integer;
  i integer := 1;
begin
  employee := employees('Kent', 'Wayne', 'Allen', 'Prince');
  first := employee.first;
  last := employee.last;
  dbms_output.put_line('First index: ' || first);
  dbms_output.put_line('Last index: ' || last);
  for i in first..last loop
    dbms_output.put_line('Element ' || i || ': ' || employee(i));
  end loop;
  employee.delete(3);
  dbms_output.put_line('Delete element on index 3');
  employee.extend;
  employee(5) := 'Quinn';
  dbms_output.put_line('Extended with one element with value Quinn');
  while i is not null loop
    dbms_output.put_line('Element ' || i || ': ' || employee(i));
    i := employee.next(i);
  end loop;
end;

-- associative arrays methods
set serveroutput on;
declare
  type salaries is table of number index by varchar2(30);
  salary salaries;
  i varchar2(50) := 'Allen';
begin
  salary('Kent') := 4200;
  salary('Wayne') := 8400;
  salary('Allen') := 3700;
  salary('Prince') := 5600;
  while i is not null loop
    dbms_output.put_line('Element ' || i || ': ' || salary(i));
    i := salary.next(i);
  end loop;
  salary.delete('Allen');
  dbms_output.put_line('Delete element on index Allen');
  salary('Quinn') := 2500;
  dbms_output.put_line('Extended with one element with value Quinn');
  i := 'Kent';
  while i is not null loop
    dbms_output.put_line('Element ' || i || ': ' || salary(i));
    i := salary.next(i);
  end loop;
end;