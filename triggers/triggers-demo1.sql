CREATE OR REPLACE TRIGGER ITEMS_BS_UPD_TRIG 
BEFORE UPDATE ON ITEMS 
BEGIN
  dbms_output.put_line('Before Statement trigger firing');
END;
/

CREATE OR REPLACE TRIGGER ITEMS_BR_UPD_TRIG 
BEFORE UPDATE ON ITEMS 
FOR EACH ROW 
BEGIN
  dbms_output.put_line('Before Row trigger firing');
END;
/
CREATE OR REPLACE TRIGGER ITEMS_AR_UPD_TRIG 
AFTER UPDATE ON ITEMS 
FOR EACH ROW 
BEGIN
  dbms_output.put_line('After Row trigger firing');
END;
/
CREATE OR REPLACE TRIGGER ITEMS_AS_UPD_TRIG 
AFTER UPDATE ON ITEMS 
BEGIN
  dbms_output.put_line('After Statement trigger firing');
END;
/

UPDATE items set item_value = item_value * 1.10;


CREATE OR REPLACE TRIGGER ITEMS_BR_UPD_TRIG2 
BEFORE UPDATE ON ITEMS 
FOR EACH ROW 
BEGIN
  dbms_output.put_line('Before Row trigger 2 firing');
END;
/
UPDATE items set item_value = item_value * 1.10;
SELECT * FROM user_triggers;
