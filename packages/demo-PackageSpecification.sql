--First create and empty package specification
CREATE OR REPLACE EDITIONABLE PACKAGE operations.order_mgmt IS
END order_mgmt;
/
CREATE OR REPLACE PACKAGE order_mgmt IS
END order_mgmt;
/

CREATE OR REPLACE PACKAGE order_mgmt IS
     --Constants
     g_order_value_limit   CONSTANT NUMBER := 10000;

     --Variables
     g_order_amount       NUMBER;

     --Subprograms    
     FUNCTION place_order(p_item_id NUMBER, p_cust_id NUMBER, p_qty NUMBER) RETURN NUMBER;
     PROCEDURE delete_order(p_order_id NUMBER);

      --Exception
      g_order_value_exception EXCEPTION;

     --Cursors
    CURSOR get_order_details RETURN orders%ROWTYPE;
END order_mgmt;
/