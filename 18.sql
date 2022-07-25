CREATE TABLE load_data
(
	t_number NUMBER,
  t_str VARCHAR2(30),
  t_date DATE
);

SELECT * FROM load_data;

DROP TABLE load_data;

--sqlldr userid=GameDBAdmin/Pa$$w0rd@//localhost:1521/orcl control=import.ctl log=import.log

SET TRIMSPOOL ON;
	SET ECHO OFF;
	SET TRIMOUT ON;
	SET LINESIZE 50;
	SET PAGESIZE 0; 
	SET FEEDBACK OFF;
	SET TIMING OFF;
	SET HEADING OFF;
	SET VERIFY OFF;
	SET TERMOUT OFF;
	SPOOL D:\Database\lab18\export.txt;
	SELECT * FROM load_data;
	SPOOL OFF;
	exit 0;

SELECT * FROM load_data WHERE TO_CHAR(sysdate,'mm') = TO_CHAR(t_date, 'mm');