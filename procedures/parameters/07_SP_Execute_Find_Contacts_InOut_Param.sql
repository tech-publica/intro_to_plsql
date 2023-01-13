DECLARE 
 num_records NUMBER;
BEGIN
 num_records := 1;
 example.find_contacts(p_last_name => 'McQuillan', p_number_results => num_records);
 dbms_output.put_line('No. records found: ' || num_records || '.');
END;