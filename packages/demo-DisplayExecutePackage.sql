DESC OPERATIONS.ORDER_MGMT

SELECT * 
  FROM ALL_OBJECTS 
 WHERE OBJECT_NAME='ORDER_MGMT';

SELECT * 
  FROM USER_SOURCE 
 WHERE NAME='ORDER_MGMT';

SELECT * 
  FROM USER_PROCEDURES 
 WHERE OBJECT_NAME = 'ORDER_MGMT';

--This will raise error that helper body not found
DECLARE 
  l_order_no NUMBER;
BEGIN
  l_order_no := operations.order_mgmt.place_order(1, 2 , 2);
END;
/
CREATE OR REPLACE PACKAGE BODY helper IS
 FUNCTION get_item_price(p_item_id NUMBER) RETURN NUMBER IS
   l_item_price NUMBER;
   BEGIN 
   SELECT item_price  
     INTO l_item_price 
     FROM items
    WHERE item_id = p_item_id;
   RETURN l_item_price;
  END get_item_price;
END helper;
/

DECLARE 
  l_order_no NUMBER;
BEGIN
  l_order_no := operations.order_mgmt.place_order(1, 2 , 2);
END;
/

BEGIN       
  operations.order_mgmt.delete_order(1);
END;
/