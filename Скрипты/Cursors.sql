declare
pul pulpits%rowtype;
curtest boolean;
begin
select * into pul from pulpits;-- where pulpit_code = 'ÂÌ';
dbms_output.put_line(pul.pulpit_code);
curtest := sql%found;
if (curtest) then
dbms_output.put_line('true');
else
dbms_output.put_line('false');
end if;
exception
when too_many_rows then
  dbms_output.put_line('too_many_rows');
when others then
  dbms_output.put_line('others');
end;

-----------------------------------------------------------------------------

declare
cursor cur_pul is select * from pulpits;
rec_pul cur_pul%rowtype;
begin
  for rec_pul in cur_pul
  loop
    dbms_output.put_line(cur_pul%rowcount ||  ', ' || rec_pul.pulpit_code || ', ' || rec_pul.pulpit_name);
  end loop;
end;

--------------------------------------------------------------------------

declare
cursor cur_pul (p_code pulpits.pulpit_code%type) is select * from pulpits where pulpit_code = p_code;
rec_pul cur_pul%rowtype;
begin
  for rec_pul in cur_pul('ÂÄ')
  loop
    dbms_output.put_line(cur_pul%rowcount ||  ', ' || rec_pul.pulpit_code || ', ' || rec_pul.pulpit_name);
  end loop;
end;

-------------------------------------------------------------------------------

declare
cursor cur_pul is select * from pulpits;
rec_pul cur_pul%rowtype;
type curtype is ref cursor return cur_pul%type;
begin
  fetch cur_pul into curtype;
  for rec_pul in curtype
  loop
    dbms_output.put_line(rec_pul.pulpit_code);
  end loop;
end;