create tablespace ts1 datafile 'ts1.dbf' size 100m reuse 
  autoextend on next 10m maxsize 100m;
create tablespace ts2 datafile 'ts2.dbf' size 100m reuse 
  autoextend on next 10m maxsize 100m;
  
alter user exam quota unlimited on ts1;

create table t_range (
  t_id number(5),
  t_name nvarchar2(20)
)
partition by range (t_id)
(
  partition p1 values less than (3) tablespace ts1,
  partition p2 values less than (maxvalue) tablespace ts2
);

select * from t_range;
insert into t_range (t_id, t_name) values (1, '1');
insert into t_range (t_id, t_name) values (3, '3');
insert into t_range (t_id, t_name) values (5, '5');

select * from t_range partition(p1);
select * from t_range partition(p2);

create table t_interval (
  t_id number(5),
  t_name nvarchar2(10)
)
partition by range(t_id) interval (3) store in (ts2)
(
  partition p1 values less than (3) tablespace ts1
);

insert into t_interval (t_id, t_name) values (1, '1');
insert into t_interval (t_id, t_name) values (3, '3');
insert into t_interval (t_id, t_name) values (5, '5');

select * from t_interval partition(p1);
SELECT * FROM user_tab_partitions WHERE tablespace_name = 'TS2';

create table t_hash (
  t_id number(5),
  t_name nvarchar2(20)
)
partition by hash(t_id)
(
  partition p1 tablespace ts1,
  partition p2 tablespace ts2
);

insert into t_hash (t_id, t_name) values (1, '1');
insert into t_hash (t_id, t_name) values (2, '2');
insert into t_hash (t_id, t_name) values (3, '3');

select * from t_hash partition (p1);
select * from t_hash partition (p2);

create table t_list (
  t_id number(5),
  t_name nvarchar2(10)
)
partition by list(t_id)
(
  partition p1 values (1) tablespace ts1,
  partition p2 values (2) tablespace ts2
);

insert into t_list (t_id, t_name) values (1, '1');
insert into t_list (t_id, t_name) values (2, '2');
insert into t_list (t_id, t_name) values (3, '3');

select * from t_list partition (p1);
select * from t_list partition (p2);