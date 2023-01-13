CREATE OR REPLACE PROCEDURE example.find_contacts
(
p_last_name         contact.last_name%type           -- Initially specify with VARCHAR2, then contact.last_name%type
)
AS
var_results           SYS_REFCURSOR;
BEGIN

OPEN var_results FOR
SELECT contact_id, first_name, last_name, date_of_birth
    FROM example.contact C
WHERE C.last_name = p_last_name;

dbms_sql.return_result(var_results);

END;