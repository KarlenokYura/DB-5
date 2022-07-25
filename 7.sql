ALTER SESSION SET "_ORACLE_SCRIPT"=true;

--1. �������� ������ ������ ������� ���������. 
SELECT name, description FROM v$BGPROCESS;--V$Bgprocess. ��� ��������, ������ ��������� ������� ���������, ������ � ������������� ������� �������������� ������� PADDR � ������� ��������� ����������������� ����� ������������ �������� ��������. ����� ������� �� ������� ������� PADDR ����� �������� 0.

--2. ���������� ������� ��������, ������� �������� � �������� � ��������� ������.
SELECT *FROM v$process ;  --spid -������������� ���������� �������� OS. 

--3. ����������, ������� ��������� DBWn �������� � ��������� ������.
--select count(*) from v$process;
show parameter db_writer_processes; --DBWn -�����, �������� � dirty - ������, ����������� � ����� ������

--4-5. �������� �������� ������� ���������� � �����������. ���������� ������ ���� ����������.
SELECT * FROM V$INSTANCE;

--6. ���������� ������� (����� ����������� ����������).
select * from V$SERVICES ;  --SYS$BACKGROUND ������������ ����������� ���������� ���� --SYS$USERS ������������ ���������� �������������, �� ��������� �������� �� ������.

--7. �������� ��������� ��� ��������� ���������� � �� ��������.
SELECT * FROM V$DISPATCHER;
show parameter DISPATCHERS;

--8. ������� � ������ Windows-�������� ������, ����������� ������� LISTENER.
--OracleOraDB12Home1TNSListener

--9. �������� �������� ������� ���������� � ���������. (dedicated, shared). 
SELECT PADDR, USERNAME, SERVER FROM V$SESSION WHERE USERNAME IS NOT NULL;
SELECT ADDR, SPID, PNAME FROM V$PROCESS WHERE BACKGROUND IS NULL ORDER BY PNAME;

--10.	����������������� � �������� ���������� ����� LISTENER.ORA. 
--11-12.	��������� ������� lsnrctl � �������� �� �������� �������. �������� ������ ����� ��������, ������������� ��������� LISTENER. 
--lsnrctl status, start, stop



























