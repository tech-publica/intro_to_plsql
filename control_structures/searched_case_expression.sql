--Nested If
DECLARE
  l_item_value NUMBER;
  l_item_category VARCHAR2(60);
  l_item_id NUMBER := 1;
  l_rating NUMBER;
BEGIN
  SELECT item_value,
         item_category 
    INTO l_item_value,
         l_item_category
    FROM items 
   WHERE item_id = l_item_id;
   DBMS_OUTPUT.PUT_LINE('Item value: '|| l_item_value || ' Item category: '||l_item_category);
   l_rating:=
     CASE
       WHEN l_item_value >= 1000 THEN 1
       WHEN l_item_value >= 750 THEN
         CASE 
           WHEN l_item_category = 'Fitness' THEN 1
           ELSE 2
         END
       WHEN l_item_value >= 500 THEN 3
       ELSE 4
     END;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
