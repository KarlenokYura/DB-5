create global temporary table temp_table (
  t_id number(6) generated as identity(start with 1 increment by 1),
  t_name nvarchar2(30) not null
) on commit preserve rows;

insert into temp_table(t_name) values ('One');
insert into temp_table(t_name) values ('Two');
insert into temp_table(t_name) values ('Three');

commit;

select * from temp_table;

drop table temp_table;