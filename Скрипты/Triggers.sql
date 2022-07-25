create or replace trigger testtrigger
  after insert or update or delete on pulpits
begin
  if inserting then
    dbms_output.put_line('Insert');
  elsif updating then
    dbms_output.put_line('Update');
  else
    dbms_output.put_line('Delete');
  end if;
end;

insert into pulpits(pulpit_code, pulpit_name) values ('TEST', 'TEST');
update pulpits set pulpit_code = 'TST' where pulpit_code = 'TEST';
delete from pulpits where pulpit_code = 'TEST';

drop trigger testtrigger;

-------------------------------------------------------------------------------

create view iview as select * from pulpits;
select * from iview;
drop view iview;

create or replace trigger itrigger
  instead of insert or update or delete on iview
begin
  if inserting then
    dbms_output.put_line('Insert - old: ' || :old.pulpit_code || ', new: ' || :new.pulpit_code);
  elsif updating then
    dbms_output.put_line('Update - old: ' || :old.pulpit_code || ', new: ' || :new.pulpit_code);
  else
    dbms_output.put_line('Delete - old: ' || :old.pulpit_code || ', new: ' || :new.pulpit_code);
  end if;
end;

select * from iview;
insert into iview(pulpit_code, pulpit_name) values ('TEST', 'TEST');
update iview set pulpit_code = 'ÂââÌ' where pulpit_code = 'ÂÌ';
delete from iview where pulpit_code = 'ÂÌ';
