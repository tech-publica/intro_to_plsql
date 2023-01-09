DECLARE
    --VALID: my_id employees.employee_id%TYPE;
    --INVALID: my_id employees.employee_id%TYPE := 1234567;
    my_id employees.employee_id%TYPE := 12345.67; --Valid but rounded to 12346 
    -- manager_id NUMBER := 1;
    -- manager_id NUMBER NOT NULL := 1;
    manager_id CONSTANT NUMBER := 1;
    dept_id manager_id%TYPE;
BEGIN
    dbms_output.put_line(my_id);
    dbms_output.put_line(manager_id);
    dbms_output.put_line(dept_id);
END;
/