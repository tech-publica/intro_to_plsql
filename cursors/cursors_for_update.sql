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
----------------------------------------
declare
    cursor country_list is
        select country_name
        from countries
        where country_name like 'Z%' FOR UPDATE;
    country VARCHAR2(100);    
begin
    open country_list;
    DBMS_SESSION.SLEEP(20);
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
        update countries set region_id=3 where country_name=country;
        dbms_output.put_line('Updated Row Count '||sql%rowcount);
     end loop; 
     close country_list;
end;
----------------------------
delete from countries where country_name like 'F%';
------------------------------
declare
    cursor country_list is
        select country_name
        from countries
        where country_name like 'Z%' FOR UPDATE;
    country VARCHAR2(100);    
begin
    open country_list;
    --DBMS_SESSION.SLEEP(20);
    loop
        fetch country_list into country;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
        update countries set region_id=3 where CURRENT OF country_list;
        dbms_output.put_line('Updated Row Count '||sql%rowcount);
     end loop; 
     close country_list;
end;
-------------------------------------------------
declare
    cursor country_list is
        select country_name, rowid
        from countries
        where country_name like 'Z%';
    country VARCHAR2(100);    
    lv_rowid UROWID;
begin
    open country_list;
    --DBMS_SESSION.SLEEP(20);
    loop
        fetch country_list into country, lv_rowid;
        exit when country_list%notfound;
        dbms_output.put_line('Country Name is '||country);    
        update countries set region_id=3 where rowid = lv_rowid;
        dbms_output.put_line('Updated Row Count '||sql%rowcount);
     end loop; 
     close country_list;
end;
