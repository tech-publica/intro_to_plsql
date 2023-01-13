--Create helper specification to demonstrate how packages make application design simple
CREATE OR REPLACE PACKAGE helper IS
   FUNCTION get_item_price (p_item_id NUMBER) RETURN NUMBER;
END helper;
/
--Implement package body for order management
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
--Implement the cursor first
--Then implement the shell of the subprograms first, also has the initialization section and compile
CREATE OR REPLACE PACKAGE BODY order_mgmt IS
    l_order_id NUMBER;
    CURSOR get_order_details RETURN orders%ROWTYPE IS
      SELECT * 
        FROM orders 
       WHERE order_id = l_order_id;

     --Subprograms
     --Specification implementations
     FUNCTION place_order(p_item_id NUMBER, p_cust_id NUMBER, p_qty NUMBER) RETURN NUMBER IS
     BEGIN
       RETURN 0;
     END place_order; 
     PROCEDURE delete_order(p_order_id NUMBER) IS
     BEGIN
       DBMS_OUTPUT.PUT_LINE('Order id '||p_order_id ||' Deleted');      
     END delete_order;
     BEGIN
       DBMS_OUTPUT.PUT_LINE('Initialization section executing'); 
       g_order_amount:=0;
END order_mgmt;
/
--Here we refer to the helper package, which does not have a body yet.
CREATE OR REPLACE PACKAGE helper IS
   FUNCTION get_item_price (p_item_id NUMBER) RETURN NUMBER;
 END helper;
 /
CREATE OR REPLACE PACKAGE BODY order_mgmt IS
    l_order_id NUMBER;
    CURSOR get_order_details RETURN orders%ROWTYPE IS
      SELECT * 
        FROM orders 
       WHERE order_id = l_order_id;

     --Subprograms
     --Specification implementations
     FUNCTION place_order(p_item_id NUMBER, p_cust_id NUMBER, p_qty NUMBER) RETURN NUMBER IS
       l_item_value NUMBER;
       l_order_id   NUMBER;
     BEGIN
       g_order_amount := 0;
       l_item_value := helper.get_item_price(p_item_id);
       IF l_item_value * p_qty > g_order_value_limit THEN
         RAISE g_order_value_exception;
       END IF;
       g_order_amount := l_item_value * p_qty;
       l_order_id := ORDER_SEQ.nextval;
       dbms_output.put_line('Placing order id '||l_order_id||' for '||g_order_amount);
       INSERT INTO orders (
         order_id,
         order_item_id,
         order_cust_id,
         order_qty
       ) VALUES (
         l_order_id,
         p_item_id,
         p_cust_id,
         p_qty
       );
       COMMIT;
       RETURN l_order_id;
     EXCEPTION
       WHEN g_order_value_exception THEN
         dbms_output.put_line('High order amount');
         RETURN 0;
     END place_order; 
     PROCEDURE delete_order(p_order_id NUMBER) IS
       l_order_row orders%ROWTYPE;
     BEGIN
       l_order_id := p_order_id;
       OPEN get_order_details;
       FETCH get_order_details INTO l_order_row;
       CLOSE get_order_details;
       DELETE FROM orders where order_id = p_order_id;  
       COMMIT;     
     END delete_order;
     BEGIN
       DBMS_OUTPUT.PUT_LINE('Initialization section executing'); 
       g_order_amount:=0;

END order_mgmt;
/
--In this iteration we will introduce private members
CREATE OR REPLACE PACKAGE BODY order_mgmt IS
    l_order_id NUMBER;
    order_not_found_exception EXCEPTION;
    CURSOR get_order_details RETURN orders%ROWTYPE IS
      SELECT * 
        FROM orders 
       WHERE order_id = l_order_id;

     --Subprograms
     --Private
     PROCEDURE reduce_balance(p_cust_id NUMBER) IS
       BEGIN
         UPDATE customers
           SET cust_balance = cust_balance - g_order_amount
           WHERE cust_id = p_cust_id;
     END reduce_balance;
     --Specification implementations
     FUNCTION place_order(p_item_id NUMBER, p_cust_id NUMBER, p_qty NUMBER) RETURN NUMBER IS
       l_item_value NUMBER;
       l_order_id   NUMBER;
     BEGIN
       g_order_amount := 0;
       l_item_value := helper.get_item_price(p_item_id);
       IF l_item_value * p_qty > g_order_value_limit THEN
         RAISE g_order_value_exception;
       END IF;
       g_order_amount := l_item_value * p_qty;
       l_order_id := ORDER_SEQ.nextval;
       dbms_output.put_line('Placing order id '||l_order_id||' for '||g_order_amount);
       INSERT INTO orders (
         order_id,
         order_item_id,
         order_cust_id,
         order_qty
       ) VALUES (
         l_order_id,
         p_item_id,
         p_cust_id,
         p_qty
       ); 
       reduce_balance(p_cust_id);
       COMMIT;
       RETURN l_order_id;
     EXCEPTION
       WHEN g_order_value_exception THEN
         dbms_output.put_line('High order amount');
         ROLLBACK;
         RETURN 0;
       WHEN OTHERS THEN
         dbms_output.put_line(SQLERRM);
         ROLLBACK;
         RETURN 0;
     END place_order; 
     PROCEDURE delete_order(p_order_id NUMBER) IS
       l_order_row orders%ROWTYPE;
     BEGIN
       l_order_id := p_order_id;
       OPEN get_order_details;
       FETCH get_order_details INTO l_order_row;
       IF get_order_details%NOTFOUND THEN
         CLOSE get_order_details;
         RAISE order_not_found_exception;
       END IF;
       CLOSE get_order_details;
       DELETE FROM orders where order_id = p_order_id;  
       COMMIT;
       EXCEPTION
         WHEN order_not_found_exception THEN
           dbms_output.put_line('Order id '||l_order_id||' not found');
           ROLLBACK;
         WHEN OTHERS THEN
           dbms_output.put_line(SQLERRM);
           ROLLBACK;     
       END delete_order;
     BEGIN
       DBMS_OUTPUT.PUT_LINE('Initialization section executing'); 
       g_order_amount:=0;
END order_mgmt;
/