------------------------------
Explicit FOR Cursor
-----------------------------
declare
    cursor country_list is
        select country_name
        from countries;
    country VARCHAR2(100);    
begin
    open country_list;
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
     end loop; 
     close country_list;
end;

-------------------------------

declare
    cursor country_list is
        select country_name
        from countries;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country_name);    
     end loop; 
end;
---------------------------------
declare
    cursor country_list is
        select country_name, country_id
        from countries;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country_name||' '||idx.country_id);    
     end loop; 
end;
--------------------------------
declare
    cursor country_list is
        select country_name || ' ' || country_id as country
        from countries;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
end;
-----------------------------------------

--------------------------
Explicit FOR cursor with parameter
-------------------------------
declare
    cursor country_list(p_region number) is
        select country_name || ' ' || country_id as country
        from countries
        where region_id=p_region;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
end;
-----------------------
declare
    cursor country_list(p_region number) is
        select country_name, country_id
        from countries
        where region_id=p_region;
begin
FOR i in country_list(1)
    loop
        dbms_output.put_line('Country Name is '||i.country_name||' '||i.country_id);    
     end loop; 
end;
------------------------------------
declare
    cursor country_list(p_region number := 1) is
        select country_name || ' ' || country_id as country
        from countries
        where region_id=p_region;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
end;
---------------------------------------
declare
    cursor country_list(p_region number := 1) is
        select country_name || ' ' || country_id as country
        from countries
        where region_id=p_region;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
     dbms_output.put_line('----------------------------------');
FOR idx in country_list(2)
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
end;
------------------------------------------
declare
begin
FOR idx in (select country_name || ' ' || country_id as country from countries)
    loop
        dbms_output.put_line('Country Name is '||idx.country);    
     end loop; 
end;
-----------------------
declare
    cursor country_list is select country_name from countries;
    cursor region_list is select region_name from regions;
begin
FOR idx in country_list
    loop
        dbms_output.put_line('Country Name is '||idx.country_name);    
     end loop; 
FOR idx in region_list
    loop
        dbms_output.put_line('Region Name is '||idx.region_name);    
     end loop;      
end;
--------------------------------------------------------------
declare
    cursor country_list is select country_name from countries;
    country VARCHAR2(100);    
    cursor region_list is select region_name from regions;
    region VARCHAR2(100);    
begin
    open country_list;
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
     end loop; 
     close country_list;
     open region_list;
    loop
        fetch region_list into region;
        exit when region_list%notfound;
        dbms_output.put_line('Region Name is '||region);    
     end loop; 
     close region_list;
end;

---------------------------------------------
declare
    TYPE ref_cursor_type is REF CURSOR;    
    entitiy_list ref_cursor_type;
    country VARCHAR2(100);    
    region VARCHAR2(100);    
begin
    open entitiy_list FOR select country_name from countries;
    loop
        fetch entitiy_list into country;
        exit when entitiy_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
     end loop; 
     close entitiy_list;
     
   open entitiy_list FOR select region_name from regions;
    loop
        fetch entitiy_list into region;
        exit when entitiy_list%notfound;
        dbms_output.put_line('Region Name is '||region);    
     end loop; 
     close entitiy_list;
end;
