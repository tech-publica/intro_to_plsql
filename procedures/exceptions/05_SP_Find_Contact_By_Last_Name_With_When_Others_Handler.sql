CREATE OR REPLACE PROCEDURE example.find_contact_by_last_name
(
 p_last_name         contact.last_name%type
)
AS
var_contact_id NUMBER;
BEGIN

SELECT contact_id INTO var_contact_id
    FROM example.contact C
WHERE C.last_name = p_last_name;

dbms_output.put_line('Contact ID found: ' || var_contact_id || '.');

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('ERROR: No contact found.');
    --WHEN too_many_rows THEN
    --    dbms_output.put_line('ERROR: Multiple contacts found.');
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR: Exception ' || SQLCODE || ' occurred. Message: ' || SQLERRM || '.');
END;