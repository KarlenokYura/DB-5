ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 20;

create table testjoba (
  t_id number(1)
);

insert into testjoba (t_id) values (1);

select * from testjoba;

create or replace procedure joba
is
begin
  dbms_output.put_line('joba');
end;

begin
joba();
end;

begin
dbms_job.isubmit(2288, 'insert into testjoba (t_id) values (1); commit;', sysdate, '(sysdate + 1/8640)');
end;

begin
dbms_job.remove(2288);
end;

begin
dbms_job.run(2288);
end;

begin
dbms_job.next_date(2288, sysdate + 1/8640);
DBMS_JOB.INTERVAL(2288, 'SYSDATE + 1/8640');
commit;
end;


select * from user_jobs;