DECLARE 
 last_name contact.last_name%type;
BEGIN
 last_name := 'McQuillan';
 example.find_contact_by_last_name(p_last_name => last_name);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error in procedure. Exception: ' || SQLCODE || ' caught. Message: ' || SQLERRM || '.');

END;