create or replace procedure insert_pulpits (
  p_code pulpits.pulpit_code%type,
  p_name pulpits.pulpit_name%type
) 
is
  cnt number(5);
  code_is_not_free exception;
  pragma exception_init (code_is_not_free, -20001);
begin
  select count(*) into cnt from pulpits where pulpit_code = p_code;
  if (cnt = 0) then
    insert into pulpits (pulpit_code, pulpit_name) values(p_code, p_name);
  else
    raise code_is_not_free;
  end if;
exception
when code_is_not_free then
  dbms_output.put_line('Code is not free');
when others then
  dbms_output.put_line('Exception when others');
end;

begin
insert_pulpits('ПИ', 'Промышленная инженерия', 23, 45);
end;