create or replace function count_pulpit (
  p_code pulpits.pulpit_code%TYPE
)
return number
is
  nmb number(5) := -1;
  cnt number(5) := 0;
  no_code_found exception;
  more_one_code exception;
  pragma exception_init (no_code_found, -20002);
begin
  select count(*) into cnt from pulpits where pulpit_code like ('%' || p_code || '%');
  if (cnt = 0) then
    raise no_code_found;
  elsif (cnt = 1) then
    select pulpit_id into nmb from pulpits where pulpit_code like ('%' || p_code || '%');
  else
    raise more_one_code;
  end if;
return nmb;
exception
when no_code_found then
  dbms_output.put_line('no_code_found');
when more_one_code then
  dbms_output.put_line('more_one_code');
when others then
  dbms_output.put_line('others');
end;

select * from pulpits;

begin
dbms_output.put_line(count_pulpit('גûפג'));
end;