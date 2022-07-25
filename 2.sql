ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--1.Создайте табличное пространство для постоянных данных 
CREATE TABLESPACE TS_KYA DATAFILE 'TS_KYA' 
SIZE 7M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M; 

--2.Создайте табличное пространство для временных данных 
CREATE TEMPORARY TABLESPACE TS_KYA_TEMP TEMPFILE 'TS_KYA_TEMP'
SIZE 5M REUSE AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

DROP TABLESPACE TS_KYA;
DROP TABLESPACE TS_KYA_TEMP;

--3.Получите список всех табличных пространств, списки всех файлов с помощью select-запроса к словарю.
SELECT * FROM DBA_TABLESPACES ;

--4.Создайте роль с именем RL_XXXCORE
CREATE ROLE RL_KYACORE;
COMMIT;

DROP ROLE RL_KYACORE;

--Назначьте ей следующие системные привилегии:
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE
      TO RL_KYACORE;

--5.Найдите с помощью select-запроса роль в словаре. Найдите с помощью select-запроса все системные привилегии, назначенные роли
SELECT * FROM SYS.DBA_SYS_PRIVS WHERE GRANTEE = 'RL_KYACORE';

--6.Создайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.
CREATE PROFILE PF_KYACORE LIMIT
      PASSWORD_LIFE_TIME 180
      SESSIONS_PER_USER 3
      FAILED_LOGIN_ATTEMPTS 7
      PASSWORD_LOCK_TIME 1
      PASSWORD_REUSE_TIME 10
      PASSWORD_GRACE_TIME DEFAULT
      CONNECT_TIME 180
      IDLE_TIME 30;
      
--7.Получите список всех профилей БД. Получите значения всех параметров профиля PF_XXXCORE. Получите значения всех параметров профиля DEFAULT.
SELECT * FROM SYS.DBA_PROFILES;

SELECT * FROM SYS.DBA_PROFILES WHERE PROFILE = 'PF_KYACORE';

SELECT * FROM SYS.DBA_PROFILES WHERE PROFILE = 'DEFAULT';

--8.Создайте пользователя с именем XXXCORE со следующими параметрами
CREATE USER KYACORE IDENTIFIED BY 12345
      DEFAULT TABLESPACE TS_KYA
      TEMPORARY TABLESPACE TS_KYA_TEMP
      PROFILE PF_KYACORE
      ACCOUNT UNLOCK;
--      PASSWORD '12345';

DROP USER KYACORE;

GRANT CREATE SESSION, 
      CREATE TABLESPACE,
      ALTER TABLESPACE,
      CREATE TABLE to KYACORE;
      
SELECT * FROM SYS.DBA_TABLES WHERE TABLE_NAME LIKE 'T';

--9.Создайте табличное пространство с именем XXX_QDATA (10m). При создании установите его в состояние offline
CREATE TABLESPACE KYA_QDATA OFFLINE
DATAFILE 'D:\KYA_QDATA.txt'
SIZE 10M REUSE
AUTOEXTEND ON NEXT 5M
MAXSIZE 20M;


--DROP TABLESPACE KYA_QDATA;

--10.Затем переведите табличное пространство в состояние online.
ALTER TABLESPACE KYA_QDATA ONLINE;

--11.Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA

ALTER USER KYACORE QUOTA 2M ON KYA_QDATA



---------------------------------------
ALTER USER KYACORE QUOTA 2 M ON TS_KYA;

--12.От имени пользователя XXX создайте таблицу в пространстве XXX_T1. В таблицу добавьте 3 строки.
CREATE TABLE t (c NUMBER);

INSERT INTO t(c) VALUES(3);
INSERT INTO t(c) VALUES(1);
INSERT INTO t(c) VALUES(2);

SELECT * FROM t;

DROP TABLE t;