SET AUTOPRINT ON;
VAR region_id NUMBER;
VAR region_name VARCHAR2(10);
EXEC :region_id := 3;
EXEC :region_name := 'ASIA';

DECLARE
    --INVALID: VAR region_id NUMBER;
BEGIN
    dbms_output.put_line(:region_id);
END;
/

VAR;

PRINT region_name;