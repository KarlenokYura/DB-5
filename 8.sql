-- 1.	Найдите на компьютере конфигурационные файлы SQLNET.ORA и TNSNAMES.ORA и ознакомьтесь с их содержимым.
--      SQLNET.ORA -cлужит для управления выполнением служб Oracle Net  
--      D:\app\HP\product\12.1.0\dbhome_1\NETWORK\ADMIN

-- 2.	Соединитесь при помощи sqlplus с Oracle как пользователь SYSTEM, получите перечень параметров экземпляра Oracle.

SELECT * FROM v$parameter;

-- 3.	Соединитесь при помощи sqlplus с подключаемой базой данных как пользователь SYSTEM, получите список табличных 
--      пространств, файлов табличных пространств, ролей и пользователей.
--      Скрины TS, FILE_TS, ROLES, USERS;

SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;
SELECT USERNAME FROM DBA_USERS;
SELECR ROLE FROM DBA_ROLES;

-- 4.	Ознакомьтесь с параметрами в HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE на вашем компьютере.
--      INST_LOG - Указывает расположение файлов Oracle Universal Installer.
--      NLS_LANG - Указывает поддерживаемый язык, территорию и набор символов. Этот параметр указывает язык, на котором появляются 
--      сообщения, территорию и ее соглашения для расчета номеров недели и дня, а также отображаемый набор символов. 
--      Oracle Universal Installer устанавливает это значение во время установки на основе языковых настроек операционной системы 

-- 5.	Запустите утилиту Oracle Net Manager и подготовьте строку подключения с именем имя_вашего_пользователя_SID, 
--      где SID – идентификатор подключаемой базы данных. 
--      Скрин NET_MANAGER

-- 6.	Подключитесь с помощью sqlplus под собственным пользователем и с применением подготовленной строки подключения. 

-- 7.	Выполните select к любой таблице, которой владеет ваш пользователь. 

-- 8.	Ознакомьтесь с командой HELP.Получите справку по команде TIMING. Подсчитайте, сколько времени длится select к любой 
--      таблице.

SET TIMING ON;
SELECT * FROM kya_t1;
SET TIMING OFF;

-- 9.	Ознакомьтесь с командой DESCRIBE.Получите описание столбцов любой таблицы.

DESCRIBE kya_t1;

-- 10.	Получите перечень всех сегментов, владельцем которых является ваш пользователь.

--SELECT * FROM dba_segments WHERE OWNER = 'SYS';
SELECT * FROM USER_SEGMENTS;

-- 11.	Создайте представление, в котором получите количество всех сегментов, количество экстентов, блоков памяти и 
--      размер в килобайтах, которые они занимают.

DROP VIEW INFO_SEGMENTS;
CREATE VIEW INFO_SEGMENTS AS
SELECT COUNT(*) Count,SUM(EXTENTS) SUM_EXTENTS, SUM(BLOCKS) SUM_BLOCKS, SUM(BYTES)/10000 SIZE_KBYTE  FROM DBA_SEGMENTS;
SELECT * FROM INFO_SEGMENTS;


connect BAZ/qwerty@localhost:1521/pdb_a ;
