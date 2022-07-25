ALTER PLUGGABLE DATABASE KYA_PDB
  OPEN READ WRITE FORCE;
  
ALTER PLUGGABLE DATABASE KYA_PDB
  CLOSE;

--1 �������� ������ ���� ������������ PDB � ������ ���������� ORA12W
select name,open_mode from v$pdbs; 

--2 ��������� ������ � ORA12W, ����������� �������� �������� �����������.
select INSTANCE_NAME from v$instance;

-- 3 ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������. 
select * from PRODUCT_COMPONENT_VERSION;

--4 �������� ����������� ��������� PDB 

--5 �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. 
select name,open_mode from v$pdbs; 

--6 ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� 
CREATE TABLESPACE TS_KYA_1
DATAFILE 'D:\KYA_1.dbf' size 7M
AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;

CREATE TABLESPACE TS_KYA_2 
DATAFILE 'D:\KYA_2.dbf' 
SIZE 7M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M; 
commit;

CREATE TEMPORARY TABLESPACE TS_KYA_TEMP
TEMPFILE 'D:\KYA_TEMP.dbf' size 5M
AUTOEXTEND ON NEXT 3M 
MAXSIZE 30M;
commit;

SELECT * FROM DBA_TABLESPACES;

drop TABLESPACE TS_KYA_1;
drop TABLESPACE TS_KYA_2;
drop TABLESPACE TS_KYA_TEMP;
commit;

create role RLKYA;
commit;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE TO RLKYA;
      
select * from DBA_ROLES where ROLE = 'RLKYA';
select * from DBA_ROLE_PRIVS where GRANTED_ROLE = 'RLKYA';
      
drop ROLE RLKYA;

create profile PFKYA limit
password_life_time 180 -- ���-�� ���� ����� ������
sessions_per_user 3 -- ���-�� ������ ��� ������������
FAILED_LOGIN_ATTEMPTS 7 -- ���-�� ������� �����
PASSWORD_LOCK_TIME 1 -- ���-�� ���� ���������� ����� ������
PASSWORD_Reuse_time 10 -- ����� ������� ���� ����� ��������� ������
password_grace_time default -- ���-�� ���� �������������� � ����� ������
connect_time 180 -- ����� ����������
idle_time 30; -- �������
commit;

select * from DBA_PROFILES where PROFILE = 'PFKYA';

drop PROFILE PFKYA;

create user U1_KYA_PDB identified by 12345
default tablespace TS_KYA_1 quota unlimited on TS_KYA_1
profile PFKYA
account unlock
password EXPIRE;

grant RLKYA to U1_KYA_PDB;
commit;

select * from DBA_USERS where USERNAME like 'U1%';

GRANT SELECT ON V_$SESSION TO U1_KYA_PDB;

drop USER U1L_KYA_PDB;

--7 ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������.
create table KYA_t (x number(3), s varchar2(50)) ;
commit;

insert into KYA_t (x, s) values (1, 'first');
insert into KYA_t (x, s) values (2, 'second');
insert into KYA_t (x, s) values (3, 'third');
commit;

select * from KYA_t;

--8 � ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ���  ����� (������������ � ���������), ��� ���� (� �������� �� ����������), 
              --������� ������������, ���� �������������  ���� ������ XXX_PDB �  ����������� �� ����
              
select * from DBA_TABLESPACES;  --��� ���. ������
select * from DBA_DATA_FILES;   --������ ������ 
select * from DBA_TEMP_FILES;  --������ ������
select * from DBA_ROLES where ROLE like 'RL%'; --����
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --��������
select * from DBA_PROFILES;  --������ ���.
select * from ALL_USERS;  --��� ������������

-- 9 ������������  � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, ����������� ����������� � ���� ������ XXX_PDB
create user C##KYA identified by 12345678
account unlock;
grant create session to C##KYA;

select * from DBA_USERS where USERNAME like '%KYA';

--10 ������������ � ������������ U1_XXX_PDB �� ������ ����������, � � ������������� C##XXX � C##YYY � ������� (� XXX_PDB-���� ������). 

SELECT username
FROM v$session
WHERE username IS NOT NULL;

--13 ������� ������������ C##XXX. ������� � SQL Developer ��� ����������� � XXX_PDB.

drop USER C##KYA;