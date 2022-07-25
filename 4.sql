ALTER PLUGGABLE DATABASE KYA_PDB
  OPEN READ WRITE FORCE;
  
ALTER PLUGGABLE DATABASE KYA_PDB
  CLOSE;

--1 Получите список всех существующих PDB в рамках экземпляра ORA12W
select name,open_mode from v$pdbs; 

--2 Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select INSTANCE_NAME from v$instance;

-- 3 Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус. 
select * from PRODUCT_COMPONENT_VERSION;

--4 Создайте собственный экземпляр PDB 

--5 Получите список всех существующих PDB в рамках экземпляра ORA12W. 
select name,open_mode from v$pdbs; 

--6 Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты 
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
password_life_time 180 -- кол-во дней жизни пароля
sessions_per_user 3 -- кол-во сессий для пользователя
FAILED_LOGIN_ATTEMPTS 7 -- кол-во попыток входа
PASSWORD_LOCK_TIME 1 -- кол-во дней блокировки после ошибки
PASSWORD_Reuse_time 10 -- через сколько дней можно повторить пароль
password_grace_time default -- кол-во дней предупреждения о смене пароля
connect_time 180 -- время соединения
idle_time 30; -- простой
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

--7 Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.
create table KYA_t (x number(3), s varchar2(50)) ;
commit;

insert into KYA_t (x, s) values (1, 'first');
insert into KYA_t (x, s) values (2, 'second');
insert into KYA_t (x, s) values (3, 'third');
commit;

select * from KYA_t;

--8 С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), все роли (и выданные им привилегии), 
              --профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли
              
select * from DBA_TABLESPACES;  --все таб. простр
select * from DBA_DATA_FILES;   --перман данные 
select * from DBA_TEMP_FILES;  --времен данные
select * from DBA_ROLES where ROLE like 'RL%'; --роли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --привилег
select * from DBA_PROFILES;  --профил без.
select * from ALL_USERS;  --все пользователи

-- 9 Подключитесь  к CDB-базе данных, создайте общего пользователя с именем C##XXX, назначьте ему привилегию, позволяющую подключится к базе данных XXX_PDB
create user C##KYA identified by 12345678
account unlock;
grant create session to C##KYA;

select * from DBA_USERS where USERNAME like '%KYA';

--10 Подключитесь к пользователю U1_XXX_PDB со своего компьютера, а к пользователям C##XXX и C##YYY с другого (к XXX_PDB-базе данных). 

SELECT username
FROM v$session
WHERE username IS NOT NULL;

--13 Удалите пользователя C##XXX. Удалите в SQL Developer все подключения к XXX_PDB.

drop USER C##KYA;