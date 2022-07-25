--1. �������� ������ ���� ������ ��������� ����������� (������������  � ���������).
SELECT tablespace_name, contents FROM DBA_TABLESPACES;

--DROP TABLESPACE KYA_QDATA; 

--2. �������� ��������� ������������ � ������ XXX_QDATA (10m). ��� �������� ���������� ��� � ��������� offline. 
--����� ���������� ��������� ������������ � ��������� online. �������� ������������ XXX ����� 2m � ������������ XXX_QDATA. 
--�� ����� XXX �  ������������ XXX_T1 �������� ������� �� ���� ��������, ���� �� ������� ����� �������� ��������� ������. � ������� �������� 3 ������.
CREATE TABLESPACE KYA_QDATA
  DATAFILE 'D:\KYA_QDATA1.dbf'
  SIZE 10 M
  OFFLINE;
  
SELECT * FROM DBA_TABLESPACES;
  
ALTER TABLESPACE KYA_QDATA ONLINE;

ALTER DATABASE DEFAULT TABLESPACE USERS ;

ALTER USER KYACORE
QUOTA 2 m ON KYA_QDATA;

select * from dba_tables WHERE TABLE_NAME = 'T1';

--user KYACORE
CREATE TABLE T1(
id number(15) PRIMARY KEY,
name varchar2(10))
tablespace KYA_QDATA;

INSERT INTO T1 values(1, 'KYA');
INSERT INTO T1 values(2, 'BED');
INSERT INTO T1 values(3, 'MAA');

SELECT * FROM T1;

DROP TABLE T1;

commit;

--3. �������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1. ���������� ��������� ��������.
--4. ������� (DROP) ������� XXX_T1. �������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1. ��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������.
SELECT owner, segment_name, segment_type, tablespace_name, bytes, blocks, buffer_pool
FROM DBA_SEGMENTS
WHERE tablespace_name='KYA_QDATA';

--������� ��� �������� �� ����� ����������� ������� ������������
--� �������� ����������������� ������� � ���������� � ������� � ������������ ��������������
--������������ � ������� ���� - PURGE
SELECT * FROM USER_RECYCLEBIN;

--5. ������������ (FLASHBACK) ��������� �������. 
FLASHBACK TABLE T1 TO BEFORE DROP;

--6. ��������� PL/SQL-������, ����������� ������� XXX_T1 ������� (10000 �����). 
BEGIN
  FOR k IN 4..10004
  LOOP
    INSERT INTO T1 VALUES(k, 'A');
  END LOOP;
  COMMIT;
END;

--7. ���������� ������� � �������� ������� XXX_T1 ���������, �� ������ � ������ � ������. �������� �������� ���� ���������. 
SELECT segment_name, segment_type, tablespace_name, bytes, blocks, extents, buffer_pool
FROM user_segments
WHERE TABLESPACE_NAME='KYA_QDATA';

--8. ������� ��������� ������������ XXX_QDATA � ��� ����. 
DROP TABLESPACE KYA_QDATA INCLUDING CONTENTS AND DATAFILES;

--9. �������� �������� ���� ����� �������� �������. ���������� ������� ������ �������� �������.  
SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;

SELECT * FROM V$LOGFILE;
ALTER SYSTEM SWITCH LOGFILE;
ALTER DATABASE ADD LOGFILE GROUP 4 'D:\APP\WEEBEEZ\ORADATA\ORCL\REDO04.LOG' 
SIZE 50 m BLOCKSIZE 512;

ALTER DATABASE ADD LOGFILE MEMBER 'D:\APP\WEEBEEZ\ORADATA\ORCL\REDO041.LOG' TO GROUP 4;
ALTER DATABASE ADD LOGFILE MEMBER 'D:\APP\WEEBEEZ\ORADATA\ORCL\REDO042.LOG' TO GROUP 4;

ALTER DATABASE DROP LOGFILE MEMBER 'D:\APP\WEEBEEZ\ORADATA\ORCL\REDO042.LOG' ;
ALTER DATABASE DROP LOGFILE MEMBER 'D:\APP\WEEBEEZ\ORADATA\ORCL\REDO041.LOG' ;

ALTER DATABASE DROP LOGFILE GROUP 4;

SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

--connect /as sysdba

--shutdown immediate;
--startup mount;

alter database archivelog;
alter database open;

SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;
SELECT * FROM V$LOG;

ALTER SYSTEM SWITCH LOGFILE;
SELECT * FROM V$ARCHIVED_LOG;

SELECT group#, sequence#, bytes, members, status, first_change# FROM V$LOG;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

ARCHIVE LOG LIST;
SHOW PARAMETER DB_RECOVERY;
show parameter log;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=D:\app\WEEBEEZ\oradata\orcl\archive'

ALTER SYSTEM archive LOG CURRENT;
SELECT log_mode FROM v$database;
 
--shutdown immediate;
--startup mount;
alter database noarchivelog;
 alter database open;
 alter pluggable database all open;
 
SELECT NAME FROM V$CONTROLFILE;
SHOW PARAMETER CONTROL;

ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile ;
CREATE PFILE = 'KYA_PFILE.ora' FROM SPFILE;

  SELECT DECODE(value, NULL, 'PFILE', 'SPFILE') "Init File Type" 
          FROM sys.v_$parameter WHERE name = 'spfile';

SELECT * FROM V$PWFILE_USERS;
SELECT * FROM V$DIAG_INFO;


alter database backup controlfile to trace;
select value from v$diag_info where name = 'Default Trace File';
