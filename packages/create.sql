If you are working in a multi-tenant database use these commands
---------------------------------------------------------------------------
--As a system user in a PDB database or you can create the operations user using the following commands
  CREATE USER operations IDENTIFIED BY operations DEFAULT TABLESPACE users;
  GRANT CONNECT, RESOURCE TO operations;


If you are working in an Autonomous database use these commands
----------------------------------------------------------------------------
--As admin user 
   --Create users
  CREATE USER operations IDENTIFIED BY operations DEFAULT TABLESPACE data;
  GRANT CONNECT, RESOURCE TO operations;


Common commands for both kind of databases:
-----------------------------------------------------------------------------


--As user operations 

  CREATE TABLE CUSTOMERS (cust_id               NUMBER  NOT NULL PRIMARY KEY,
                          cust_name             VARCHAR2(100) NOT NULL,
                          cust_location         VARCHAR2(2) NOT NULL,
                          cust_balance          NUMBER(10,2));
  CREATE TABLE ITEMS     (item_id               NUMBER  NOT NULL PRIMARY KEY,
                          item_name             VARCHAR2(60) NOT NULL,
                          item_price            NUMBER(5,2) NOT NULL  );
  CREATE TABLE ORDERS    (order_id              NUMBER  NOT NULL PRIMARY KEY,
                          order_item_id         NUMBER NOT NULL,
                          order_cust_id         NUMBER NOT NULL,
                          order_qty             NUMBER   NOT NULL,
                          CONSTRAINT order_item_fk FOREIGN KEY (order_item_id)
                          REFERENCES items(item_id),
                          CONSTRAINT  order_cust_fk FOREIGN KEY (order_cust_id)  
                          REFERENCES customers(cust_id) );
  CREATE SEQUENCE order_seq START WITH 1;

  -- INSERT INTO customers table
  INSERT INTO customers(cust_id,cust_name,cust_location,cust_balance) VALUES (1,'John','WA',20000);
  INSERT INTO customers(cust_id,cust_name,cust_location,cust_balance) VALUES (2,'Jack','CA',10000);
  INSERT INTO customers(cust_id,cust_name,cust_location,cust_balance) VALUES (3,'Jill','CA',15000);
  INSERT INTO customers(cust_id,cust_name,cust_location,cust_balance) VALUES (4,'Jill','CA',8000);

  -- INSERT INTO items table
  INSERT INTO items(item_id,item_name,item_price) VALUES (1,'Treadmill', 500);
  INSERT INTO items(item_id,item_name,item_price) VALUES (2,'Elliptical',700);
  INSERT INTO items(item_id,item_name,item_price) VALUES (3,'Weights',100);
  INSERT INTO items(item_id,item_name,item_price) VALUES (4,'Scooter',200); 
  COMMIT;
