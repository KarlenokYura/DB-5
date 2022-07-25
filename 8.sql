-- 1.	������� �� ���������� ���������������� ����� SQLNET.ORA � TNSNAMES.ORA � ������������ � �� ����������.
--      SQLNET.ORA -c����� ��� ���������� ����������� ����� Oracle Net  
--      D:\app\HP\product\12.1.0\dbhome_1\NETWORK\ADMIN

-- 2.	����������� ��� ������ sqlplus � Oracle ��� ������������ SYSTEM, �������� �������� ���������� ���������� Oracle.

SELECT * FROM v$parameter;

-- 3.	����������� ��� ������ sqlplus � ������������ ����� ������ ��� ������������ SYSTEM, �������� ������ ��������� 
--      �����������, ������ ��������� �����������, ����� � �������������.
--      ������ TS, FILE_TS, ROLES, USERS;

SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;
SELECT USERNAME FROM DBA_USERS;
SELECR ROLE FROM DBA_ROLES;

-- 4.	������������ � ����������� � HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE �� ����� ����������.
--      INST_LOG - ��������� ������������ ������ Oracle Universal Installer.
--      NLS_LANG - ��������� �������������� ����, ���������� � ����� ��������. ���� �������� ��������� ����, �� ������� ���������� 
--      ���������, ���������� � �� ���������� ��� ������� ������� ������ � ���, � ����� ������������ ����� ��������. 
--      Oracle Universal Installer ������������� ��� �������� �� ����� ��������� �� ������ �������� �������� ������������ ������� 

-- 5.	��������� ������� Oracle Net Manager � ����������� ������ ����������� � ������ ���_������_������������_SID, 
--      ��� SID � ������������� ������������ ���� ������. 
--      ����� NET_MANAGER

-- 6.	������������ � ������� sqlplus ��� ����������� ������������� � � ����������� �������������� ������ �����������. 

-- 7.	��������� select � ����� �������, ������� ������� ��� ������������. 

-- 8.	������������ � �������� HELP.�������� ������� �� ������� TIMING. �����������, ������� ������� ������ select � ����� 
--      �������.

SET TIMING ON;
SELECT * FROM kya_t1;
SET TIMING OFF;

-- 9.	������������ � �������� DESCRIBE.�������� �������� �������� ����� �������.

DESCRIBE kya_t1;

-- 10.	�������� �������� ���� ���������, ���������� ������� �������� ��� ������������.

--SELECT * FROM dba_segments WHERE OWNER = 'SYS';
SELECT * FROM USER_SEGMENTS;

-- 11.	�������� �������������, � ������� �������� ���������� ���� ���������, ���������� ���������, ������ ������ � 
--      ������ � ����������, ������� ��� ��������.

DROP VIEW INFO_SEGMENTS;
CREATE VIEW INFO_SEGMENTS AS
SELECT COUNT(*) Count,SUM(EXTENTS) SUM_EXTENTS, SUM(BLOCKS) SUM_BLOCKS, SUM(BYTES)/10000 SIZE_KBYTE  FROM DBA_SEGMENTS;
SELECT * FROM INFO_SEGMENTS;


connect BAZ/qwerty@localhost:1521/pdb_a ;
