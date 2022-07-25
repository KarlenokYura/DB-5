--1.���������� ����� ������ ������� SGA.
select * from v$sga;
select SUM(VALUE) from v$sga;

--2.���������� ������� ������� �������� ����� SGA.
select * from v$sga_dynamic_components where current_size > 0;

--3.���������� ������� ������� ��� ������� ����.
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components where current_size > 0;

--4.���������� ����� ��������� ��������� ������ � SGA.
--select sum(min_size), sum(max_size), sum(current_size) from v$sga_dynamic_components;
select current_size from v$sga_dynamic_free_memory;

--5.���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.
select component, min_size, current_size, max_size from v$sga_dynamic_components; --where current_size > 0;

--6.�������� �������, ������� ����� ���������� � ��� ���P. ����������������� ������� �������.
create table MyTable(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';
drop table MyTable;

--7.�������� �������, ������� ����� ������������ � ���� default. ����������������� ������� �������.
create table MyTable2(x int) storage(buffer_pool default);
--�������� ������ ������� �� �������� �����
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where lower(segment_name) like '%mytable%';
drop table MyTable2;

--8.������� ������ ������ �������� �������.
show parameter log_buffer;

--9.������� 10 ����� ������� �������� � ����������� ����.
select * from (select pool, name, bytes from v$sgastat where pool = 'shared pool' order by bytes desc) where rownum <= 10;
--select type from v$db_object_cache where lower(pin_mode) like '%shared%';

--10.������� ������ ��������� ������ � ������� ����.
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

--11.�������� �������� ������� ���������� � ���������.
select username, server from v$session where username is not null;

--12.���������� ������ ������� ���������� � ��������� (dedicated, shared).
select username, server from v$session;

--13.*������� ����� ����� ������������ ������� � ���� ������.
select table_name, total_phys_io
    from ( select owner||'.'||object_name as table_name,
                  sum(value) as total_phys_io
           from   v$segment_statistics
           where  owner!='SYS' and ( object_type='TABLE' OR object_type='INDEX' )
     and  statistic_name in ('physical reads','physical reads direct',
                           'physical writes','physical writes direct')
           group by owner||'.'||object_name
           order by total_phys_io desc)
    where rownum <=25;
