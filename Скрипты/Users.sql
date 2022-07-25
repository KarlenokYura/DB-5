alter session set "_ORACLE_SCRIPT" = TRUE;

create user exam
   identified by Pa$$w0rd
   default tablespace Users
   quota 15m on Users;
   
grant create session to exam;
grant create table to exam;
grant create view to exam;
grant create materialized view to exam;
grant create sequence to exam;
grant create cluster to exam;
grant create synonym to exam;
grant create procedure to exam;
grant create trigger to exam;
grant create tablespace to exam;
grant alter tablespace to exam;
grant all privileges to exam;

alter user exam quota unlimited on ts1;
alter user exam quota unlimited on ts2;
commit;