CREATE OR REPLACE TRIGGER  demo.accounts_br_ins_upd_del_trig
    BEFORE INSERT 
    OR UPDATE 
    OR DELETE ON demo.accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Inserting');
    :NEWER.act_insert_user := USER;
    :NEWER.act_insert_datetime := SYSTIMESTAMP;
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Deleting');
  END IF;
  IF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Updating');
    :NEWER.act_update_user := USER;
    :NEWER.act_update_datetime := SYSTIMESTAMP;
  END IF;
END;
/
SELECT * FROM accounts;
INSERT INTO ACCOUNTS (act_id, act_cust_id, act_bal) VALUES (5,1,1000);
SELECT * FROM accounts;
INSERT INTO ACCOUNTS (act_id, act_cust_id, act_bal, act_insert_user) VALUES (6,1,1000,'TOM');
SELECT * FROM accounts;
DELETE FROM accounts WHERE act_id = 6;
SELECT * FROM accounts;

--before update of column name condition
update accounts set act_cust_id=2 where act_id = 1;
SELECT * FROM accounts;

CREATE OR REPLACE TRIGGER  demo.accounts_br_ins_upd_del_trig
    BEFORE INSERT 
    OR UPDATE  
     OF act_bal
    OR DELETE ON demo.accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Inserting');
    :NEWER.act_insert_user := USER;
    :NEWER.act_insert_datetime := SYSTIMESTAMP;
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Deleting');
  END IF;
  IF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Updating');
    :NEWER.act_update_user := USER;
    :NEWER.act_update_datetime := SYSTIMESTAMP;
  END IF;
END;
/

--after update of column name condition to act_bal
update accounts set act_cust_id=1 where act_id = 1;
SELECT * FROM accounts;

CREATE OR REPLACE TRIGGER  demo.accounts_br_ins_upd_del_trig
    BEFORE INSERT 
    OR UPDATE  
     OF act_bal
   , act_cust_id
    OR DELETE ON demo.accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Inserting');
    :NEWER.act_insert_user := USER;
    :NEWER.act_insert_datetime := SYSTIMESTAMP;
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Deleting');
  END IF;
  IF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Updating');
    :NEWER.act_update_user := USER;
    :NEWER.act_update_datetime := SYSTIMESTAMP;
  END IF;
END;
/

--after update of column name condition to include act_cust_id along with act_bal
update accounts set act_cust_id=2 where act_id = 1;
SELECT * FROM accounts;

CREATE OR REPLACE TRIGGER  demo.accounts_br_ins_upd_del_trig
    BEFORE INSERT 
    OR UPDATE  
     OF act_bal 
   , act_cust_id 
    OR DELETE ON demo.accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
    WHEN (NEWER.act_bal < 1000) 
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Inserting');
    :NEWER.act_insert_user := USER;
    :NEWER.act_insert_datetime := SYSTIMESTAMP;
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Deleting');
  END IF;
  IF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Updating');
    :NEWER.act_update_user := USER;
    :NEWER.act_update_datetime := SYSTIMESTAMP;
  END IF;
END;
/

--after act_bal conditon act_bal< 1000
update accounts set act_bal=1001 where act_id = 1;
update accounts set act_bal=999 where act_id = 1;

CREATE OR REPLACE TRIGGER  demo.accounts_br_ins_upd_del_trig
    BEFORE INSERT 
    OR UPDATE  
     OF act_bal
   , act_cust_id 
    OR DELETE ON demo.accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
    WHEN (NEWER.act_bal < 1000) 
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Inserting');
    :NEWER.act_insert_user := USER;
    :NEWER.act_insert_datetime := SYSTIMESTAMP;
  END IF;
  IF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Deleting');
  END IF;
  IF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Updating');
    :NEWER.act_update_user := USER;
    :NEWER.act_update_datetime := SYSTIMESTAMP;
  END IF;
  IF UPDATING('act_cust_id') THEN
    DBMS_OUTPUT.PUT_LINE('Updating customer id');
  END IF;
END;
/

-- Have a customized section for update of cust id
update accounts set act_bal=999, act_cust_id=1 where act_id = 1;
-- Show that the condition in the trigger clause has to be true
update accounts set act_bal=1001, act_cust_id=1 where act_id = 1;
SELECT * FROM accounts;
DELETE FROM ACCOUNTS WHERE act_id = 5;
