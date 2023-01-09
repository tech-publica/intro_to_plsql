--Simple if 
DECLARE
  l_item_value NUMBER;
  l_item_category VARCHAR2(60);
  l_item_id NUMBER := 2;
  l_rating NUMBER := 2;
BEGIN
  SELECT item_value,
         item_category 
    INTO l_item_value,
         l_item_category
    FROM items 
   WHERE item_id = l_item_id;
   DBMS_OUTPUT.PUT_LINE('Item value: '|| l_item_value || ' Item category: '||l_item_category);
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
--Simple if else
DECLARE
  l_item_value NUMBER;
  l_item_category VARCHAR2(60);
  l_item_id NUMBER := 1;
  l_rating NUMBER := 2;
BEGIN
  SELECT item_value,
         item_category 
    INTO l_item_value,
         l_item_category
    FROM items 
   WHERE item_id = l_item_id;
   DBMS_OUTPUT.PUT_LINE('Item value: '|| l_item_value || ' Item category: '||l_item_category);
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   ELSE
     l_rating := 2;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
--if elsif else null value
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
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   ELSIF (l_item_value >= 750) THEN
     l_rating := 2;
   ELSIF l_item_value >= 500 THEN
     l_rating := 3;
   ELSE
     l_rating := 4;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
--Multiple Conditions
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
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   ELSIF (l_item_value >= 750 AND l_item_category = 'Fitness') THEN
     l_rating := 1;
   ELSIF (l_item_value >= 750) THEN
     l_rating := 2;
   ELSIF l_item_value >= 500 THEN
     l_rating := 3;
   ELSE
     l_rating := 4;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
--Multiple Conditions with wrong order
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
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   ELSIF (l_item_value >= 750) THEN
     l_rating := 2;
   ELSIF (l_item_value >= 750 AND l_item_category = 'Fitness') THEN
     l_rating := 1;
   ELSIF l_item_value >= 500 THEN
     l_rating := 3;
   ELSE
     l_rating := 4;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/

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
   IF l_item_value >= 1000 THEN
     l_rating := 1;
   ELSIF (l_item_value >= 750) THEN
     IF (l_item_category = 'Fitness') THEN
       l_rating := 1;
     ELSE
       l_rating := 2;
     END IF;
   ELSIF l_item_value >= 500 THEN
     l_rating := 3;
   ELSE
     l_rating := 4;
   END IF;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/
