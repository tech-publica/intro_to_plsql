--CASE Statement
DECLARE
  l_day VARCHAR2(10):='Weekday';
  l_qty VARCHAR2(1); 
  l_gameday VARCHAR2(1) := 'Y';  
BEGIN
    CASE l_day
    WHEN 'Friday' THEN
      l_qty :='H';
    WHEN 'Weekday' THEN
      CASE l_gameday
      WHEN 'Y' THEN
        l_qty :='H';
      ELSE
        l_qty :='L';
      END CASE;
    WHEN 'Holiday' THEN
      l_qty :='H';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
END;
/
--CASE_NOT_FOUND Exception
DECLARE
  l_day VARCHAR2(10):='Weekend';
  l_qty VARCHAR2(1); 
  l_gameday VARCHAR2(1) := 'Y';  
BEGIN
    CASE l_day
    WHEN 'Friday' THEN
      l_qty :='H';
    WHEN 'Weekday' THEN
      CASE l_gameday
      WHEN 'Y' THEN
        l_qty :='H';
      ELSE
        l_qty :='L';
      END CASE;
    WHEN 'Holiday' THEN
      l_qty :='H';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
EXCEPTION
  WHEN CASE_NOT_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('CASE:'||l_day||' not found');
END;
/

--Null case selector
DECLARE
  l_day VARCHAR2(10);
  l_qty VARCHAR2(1); 
  l_gameday VARCHAR2(1) := 'Y';  
BEGIN
    CASE l_day
    WHEN 'Friday' THEN
      l_qty :='H';
    WHEN 'Weekday' THEN
      CASE l_gameday
      WHEN 'Y' THEN
        l_qty :='H';
      ELSE
        l_qty :='L';
      END CASE;
    WHEN 'Holiday' THEN
      l_qty :='H';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
EXCEPTION
  WHEN CASE_NOT_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('CASE:'||l_day||' not found');
END;
/
--Null case selector
DECLARE
  l_day VARCHAR2(10);
  l_qty VARCHAR2(1); 
  l_gameday VARCHAR2(1) := 'Y';  
BEGIN
    CASE l_day
    WHEN 'Friday' THEN
      l_qty :='H';
    WHEN 'Weekday' THEN
      CASE l_gameday
      WHEN 'Y' THEN
        l_qty :='H';
      ELSE
        l_qty :='L';
      END CASE;
    WHEN 'Holiday' THEN
      l_qty :='H';
    ELSE 
      l_qty := 'L';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
EXCEPTION
  WHEN CASE_NOT_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('CASE:'||l_day||' not found');
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
   CASE TRUE
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