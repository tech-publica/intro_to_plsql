DECLARE
    hours_worked NUMBER DEFAULT 100;
    salary NUMBER := hours_worked * 90;
BEGIN
    salary := 9999;
    dbms_output.put_line('Salary: ' || salary);
END;
/