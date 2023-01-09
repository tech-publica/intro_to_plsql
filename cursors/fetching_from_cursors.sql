declare
    country VARCHAR2(100);
begin
    select country_name
    into country
    from countries
    where country_id LIKE '%S';

    dbms_output.put_line('Country Name is '||country);    

end;
------------------------------------------
declare
    type country_list_type is table of VARCHAR2(100);
    country_list country_list_type := country_list_type();
begin
    select country_name
    bulk collect into country_list
    from countries;
    --where country_id LIKE '%S';
    
    for i in country_list.first ..country_list.last
    loop
        dbms_output.put_line('Country Name is '||country_list(i));    
     end loop; 
end;
------------------------------------------------
declare
    cursor country_list is
        select country_name
        from countries;
    country VARCHAR2(100);    
begin
    open country_list;
     fetch country_list into country;
     dbms_output.put_line('Country Name is '||country);    
     close country_list;
end;

-------------------------------------------------------------
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
-----------------------------------------------------
declare
    cursor country_list is
        select country_name, country_id
        from countries;
    country VARCHAR2(100);    
    country_id VARCHAR2(10);
begin
    open country_list;
    loop
        fetch country_list into country, country_id;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country||' '||country_id);    
     end loop; 
     close country_list;
end;
--------------------------------------------------------
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
    country VARCHAR2(100);    
begin
    dbms_output.put_line('Row Count '||country_list%rowcount);
    open country_list;
    if(country_list%isopen) then
    dbms_output.put_line('is open ');
else 
    dbms_output.put_line('is closed ');
end if;   
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
     end loop; 
     close country_list;
end;
--------------------
declare
    country VARCHAR2(100);
begin
    select country_name
    into country
    from countries
    where country_id LIKE '%S';

    dbms_output.put_line('Row CoUnt is '||SQL%Rowcount);

end;
----------------
declare
    cursor country_list(p_region number) is
        select country_name
        from countries
        where region_id=p_region;
    country VARCHAR2(100);    
begin
    open country_list(2);
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
     end loop; 
     close country_list;
end;
------------------------------------------------------
