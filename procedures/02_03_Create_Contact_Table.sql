SET SERVEROUTPUT ON;

DECLARE 
    counter INT;
    tbl_name  VARCHAR2(30) := 'contact';
BEGIN
    SELECT COUNT(*) INTO counter from user_tables WHERE LOWER(table_name) = LOWER(tbl_name);
    IF counter = 1 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ' || tbl_name;
    END IF;

    EXECUTE IMMEDIATE '
    CREATE TABLE contact 
    (
     contact_id         NUMBER(6)        GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
     first_name         VARCHAR2(40)     CONSTRAINT contact_first_name_notnull NOT NULL,
     last_name          VARCHAR2(40)     CONSTRAINT contact_last_name_notnull NOT NULL,
     date_of_birth      DATE,
     CONSTRAINT contact_pk PRIMARY KEY (contact_id),
     CONSTRAINT contact_first_name_and_last_name CHECK (COALESCE(first_name, '''') != '''' AND COALESCE(last_name, '''') != '''')
    )
    ';

    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Stephen'',''Gerrard'',DATE ''1980-05-30'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Dennis'',''Potter'',DATE ''1935-05-17'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Richard'',''Adams'',DATE ''1920-05-09'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Bertie'',''McQuillan'',DATE ''2001-06-30'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Walt'',''Disney'',DATE ''1966-12-05'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Barbara'',''Gordon'',DATE ''1952-01-11'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Josephine'',''Bailey'',DATE ''1949-05-31'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Linda'',''Canoglu'',DATE ''1959-07-11'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Grace'',''McQuillan'',DATE ''1993-09-27'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Vera'',''Black'',DATE ''1984-08-03'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Angelica'',''Jones'',DATE ''1981-02-04'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Steve'',''Davis'',DATE ''1957-08-22'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Allison'',''Fisher'',DATE ''1968-02-24'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Julius'',''Marx'',DATE ''1990-10-02'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''George'',''Formby'',DATE ''1944-05-26'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Alan'',''Partridge'',DATE ''1965-04-14'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Harper'',''Lee'',DATE ''1986-04-28'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Robert'',''Burns'',DATE ''1959-01-25'')';
    EXECUTE IMMEDIATE 'INSERT INTO contact (first_name, last_name, date_of_birth) VALUES (''Roald'',''Dahl'',DATE ''1916-09-13'')';
    
    COMMIT;
END;