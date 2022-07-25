--Task 1

grant create database link 
   to gamedbadmin;

CREATE DATABASE LINK lizalink
CONNECT TO system IDENTIFIED BY Pa$$w0rd
using 'LIZA';

create table yura_t(
yura_id number(10) generated as identity(start with 1 increment by 1),
yura_name varchar2(30) not null,
yura_number number(3) not null,
CONSTRAINT yura_pk PRIMARY KEY (yura_id)
);
COMMIT;

SELECT * FROM yura_t;

DROP TABLE yura_t;

DROP DATABASE LINK lizalink;

--Task 2

SELECT * FROM A_T@lizalink;

INSERT INTO A_T@lizalink(a_name) VALUES ('TestInsert');
COMMIT A_T@lizalink;

UPDATE A_T@lizalink SET a_name = 'TestUpdate' WHERE a_name = 'TestInsert';
COMMIT A_T@lizalink;

DELETE A_T@lizalink WHERE a_name = 'TestUpdate';
COMMIT A_T@lizalink;

--Task 3

CREATE PUBLIC DATABASE LINK p_lizalink
CONNECT TO system IDENTIFIED BY Pa$$w0rd
USING 'LIZA';

DROP DATABASE LINK p_lizalink;

--Task 4

SELECT * FROM A_T@p_lizalink;

INSERT INTO A_T@p_lizalink(a_name) VALUES ('TestInsert');
COMMIT A_T@p_lizalink;

UPDATE A_T@p_lizalink SET a_name = 'TestUpdate' WHERE a_name = 'TestInsert';
COMMIT A_T@p_lizalink;

DELETE A_T@p_lizalink WHERE a_name = 'TestUpdate';
COMMIT A_T@p_lizalink;

--Insert/Insert

create or replace procedure insert_insert (
  p_name varchar2,
  p_number number
) 
is
begin
  insert into yura_t(yura_name, yura_number) values (p_name, p_number);
  insert into a_t@lizalink(a_name, a_number) values (p_name, p_number);
  commit;
--exception
--when others then
--  dbms_output.put_line('Insert error');
end;

begin
insert_insert('Liza', 54);
end;

drop procedure insert_insert;

select * from yura_t;
select * from a_t@lizalink;

--Insert/Updates

create or replace procedure insert_update (
  p_name varchar2,
  p_number number,
  p_id number
) 
is
begin
  insert into yura_t(yura_name, yura_number) values (p_name, p_number);
  update a_t@lizalink SET a_name = p_name, a_number = p_number where a_id = p_id;
  commit;
--exception
--when others then
--  dbms_output.put_line('Insert error');
end;

begin
insert_update('Lizaaaa', 544, 1);
end;

drop procedure insert_update;

select * from yura_t;
select * from a_t@lizalink;

--Updates/Insert

create or replace procedure update_insert (
  p_name varchar2,
  p_number number,
  p_id number
) 
is
begin
  update yura_t SET yura_name = p_name, yura_number = p_number where yura_id = p_id;
  insert into a_t@lizalink (a_name, a_number) values (p_name, p_number);
  commit;
--exception
--when others then
--  dbms_output.put_line('Insert error');
end;

begin
update_insert('Yura', 112, 2);
end;

drop procedure update_insert;

select * from yura_t;
select * from a_t@lizalink;

--insert_100k

CREATE OR REPLACE PROCEDURE insert_100k
IS
BEGIN
    for i in 1 .. 100000 loop
    insert into yura_t (yura_name, yura_number) values ('100K', 100);
    end loop;
    commit;
END insert_100k;

BEGIN
insert_100k();
END;