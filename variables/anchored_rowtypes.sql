DECLARE
    job_rec jobs%ROWTYPE;
BEGIN
    --INVALID: job_rec.min_salary := 1234567;
    job_rec.min_salary := 123456;
    --INVALID: SELECT job_id INTO job_rec FROM jobs WHERE job_id = 'IT_PROG';
    SELECT * INTO job_rec FROM jobs WHERE job_id = 'IT_PROG';
    dbms_output.put_line('job_id: ' || job_rec.job_id);
    dbms_output.put_line('job_title: ' || job_rec.job_title);
    dbms_output.put_line('min_salary: ' || job_rec.min_salary);
    dbms_output.put_line('max_salary: ' || job_rec.max_salary);
END;
/