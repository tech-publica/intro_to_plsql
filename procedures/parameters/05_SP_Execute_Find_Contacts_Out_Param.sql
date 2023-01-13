DECLARE 
 num_records NUMBER;
BEGIN
 example.find_contacts('McQuillan', num_records);
 dbms_output.put_line('No. records found: ' || num_records || '.');
END;