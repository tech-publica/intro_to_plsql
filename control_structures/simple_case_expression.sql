--CASE Expression
DECLARE
  l_day VARCHAR2(10):= 'Weekday';
  l_qty VARCHAR2(1);
BEGIN
    l_qty := 
      CASE l_day
        WHEN 'Friday'  THEN 'H'
        WHEN 'Weekday' THEN 'L'
        WHEN 'Holiday' THEN 'H'
        ELSE 'H'
      END;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
END;
/
--CASE Expression with no match and no else
DECLARE
  l_day VARCHAR2(10) := 'Weekend';
  l_qty VARCHAR2(1);
BEGIN
    l_qty := 
      CASE l_day
        WHEN 'Friday'  THEN 'H'
        WHEN 'Weekday' THEN 'L'
        WHEN 'Holiday' THEN 'H'
      END;
    DBMS_OUTPUT.PUT_LINE('Qty:'||l_qty);
END;
/