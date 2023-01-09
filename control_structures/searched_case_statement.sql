--Searched CASE Statement
DECLARE
  l_day VARCHAR2(10):='Weekday';
  l_qty VARCHAR2(1);
  l_gameday VARCHAR2(1) := 'Y'; 
BEGIN
    CASE
    WHEN l_day = 'Friday' THEN
      l_qty :='H';
    WHEN (l_day = 'Weekday' AND l_gameday = 'Y') THEN
      l_qty :='H';
    WHEN l_day = 'Weekday' THEN
      l_qty :='L';
    WHEN l_day = 'Holiday' THEN
      l_qty :='H';
    WHEN l_day IS NULL THEN
      l_qty :='H';
    ELSE
      l_qty :='H';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
END;
/
--Searched CASE Statement
DECLARE
  l_day VARCHAR2(10);
  l_qty VARCHAR2(1);
  l_gameday VARCHAR2(1) := 'Y'; 
BEGIN
    CASE
    WHEN l_day = 'Friday' THEN
      l_qty :='H';
    WHEN (l_day = 'Weekday' AND l_gameday = 'Y') THEN
      l_qty :='H';
    WHEN l_day = 'Weekday' THEN
      l_qty :='L';
    WHEN l_day = 'Holiday' THEN
      l_qty :='H';
    WHEN l_day IS NULL THEN
      l_qty :='H';
    ELSE
      l_qty :='H';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
END;
/

--CASE Statement
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
   CASE
   WHEN l_item_value >= 1000 THEN
     l_rating := 1;
   WHEN l_item_value >= 750 THEN
     l_rating := 2;
   WHEN l_item_value >= 500 THEN
     l_rating := 3;
   ELSE
     l_rating := 4;
   END CASE;
   DBMS_OUTPUT.PUT_LINE('Item rating: '|| l_rating);
END;
/