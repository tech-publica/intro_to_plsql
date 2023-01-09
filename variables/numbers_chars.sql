DECLARE
    --Prints 150: salary NUMBER(3) := 149.99;
    --INVALID: salary NUMBER(3) := 999.99;
    --Prints 1000: salary NUMBER(3, -2) := 999.99;
    salary NUMBER(3, 2) := 9.119; --Prints 9.12
    --INVALID: categoryA VARCHAR2 := 'A';
    --INVALID: categoryA(5) VARCHAR2 := 'ABCDEF';
    categoryA VARCHAR2(5) := 'A';
    categoryB CHAR(5) := 'B';
    --INVALID: paid BOOLEAN := 1;
    paid BOOLEAN := TRUE
BEGIN
    dbms_output.put_line(salary);
    dbms_output.put_line('*' || categoryA || '*');
    dbms_output.put_line('*' || categoryB || '*');
    
    dbms_output.put_line(
        CASE
            WHEN paid IS NULL THEN 'UNKNOWN'
            WHEN paid THEN 'PAID'
            WHEN NOT paid THEN 'NOT PAID'
        END
    );
END;
/