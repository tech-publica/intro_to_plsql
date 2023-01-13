CREATE OR REPLACE PROCEDURE example.find_contacts
(
 p_last_name        contact.last_name%type,
 p_number_results   NUMBER DEFAULT 1
)
AS
var_results     SYS_REFCURSOR;
BEGIN

OPEN var_results FOR
SELECT contact_id, first_name, last_name, date_of_birth
    FROM example.contact C
WHERE LOWER(C.last_name) = LOWER(p_last_name)
FETCH FIRST p_number_results ROWS ONLY;

dbms_sql.return_result(var_results);

END;