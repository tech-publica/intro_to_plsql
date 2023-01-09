DECLARE
    dept_name CONSTANT VARCHAR(100) NOT NULL := 'IT';
    --INVALID: CONSTANT dept_name NOT NULL VARCHAR2(100) := 'IT';
BEGIN
    dbms_output.put_line('dept_name: ' || dept_name);
    --dept_name := 'Sales';
    dbms_output.put_line('new dept_name: ' || dept_name);
END;
/