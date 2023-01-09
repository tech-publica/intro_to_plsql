DECLARE
    salary NUMBER := 1000;
    --INVALID: 1salary NUMBER := 1000;
    --VALID: salary1$#_$#_1 NUMBER := 1000;
    --INVALID: salary-emp NUMBER := 1000;
    --VALID: "salary-emp" NUMBER := 1000;
    --VALID: "salary  emp" NUMBER := 1000;
    --VALID: "salary" NUMBER := 1000;
    --INVALID: SALARY NUMBER := 2000;
    --VALID: "SALARY" NUMBER := 2000;
    "ALL" NUMBER := 2000;
BEGIN
    --dbms_output.put_line(salary);
    --dbms_output.put_line("salary-emp");
    --dbms_output.put_line("salary  emp");
    --dbms_output.put_line("salary");
    --dbms_output.put_line("Salary");
    --INVALID: dbms_output.put_line(all);
    --INVALID: dbms_output.put_line(ALL);
    dbms_output.put_line("ALL");
END;
/