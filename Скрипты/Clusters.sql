create cluster c1 (t_id number(6)) hashkeys 200;

create table t_a (
  t_id number(6)
) cluster c1 (t_id);

create table t_b (
  t_id number(6)
) cluster c1 (t_id);

create table t_c (
  t_id number(6)
) cluster c1 (t_id);

insert into t_a(t_id) values (1);
insert into t_a(t_id) values (2);
insert into t_a(t_id) values (3);

insert into t_b(t_id) values (1);
insert into t_b(t_id) values (2);

insert into t_c(t_id) values (1);

commit;

select * from user_clusters;
select * from user_tables where table_name like 'T_%';