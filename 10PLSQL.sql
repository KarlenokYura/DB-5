--Task 1
BEGIN 
NULL;
END;

--Task 2
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello World');
END;

--Task 3
DECLARE 
  x NUMBER(1) := 1;
  y NUMBER(1) := 0;
  z NUMBER(1);
BEGIN
  z := x / y;
  DBMS_OUTPUT.PUT_LINE('z = ' || z);
EXCEPTION
  WHEN OTHERS
  THEN DBMS_OUTPUT.PUT_LINE('ERROR SQLCODE: ' || sqlcode || ', SQLERRM: ' || sqlerrm);
END;

--Task 4
DECLARE 
  x NUMBER(1) := 1;
  y number(1) := 0;
  z number(1);
BEGIN
  DBMS_OUTPUT.PUT_LINE('x + y = ' || (x + y));
  BEGIN
    z := x / y;
    DBMS_OUTPUT.PUT_LINE('z (before) = ' || z);
  EXCEPTION
    WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE('ERROR: ' || sqlerrm);
  END;
  DBMS_OUTPUT.PUT_LINE('z (after) = ' || z);
END;

--Task 5
SHOW PARAMETERS plsql_warnings;
SELECT name, value FROM v$parameter WHERE name = 'plsql_warnings';

ALTER SYSTEM SET plsql_warnings = 'ENABLE:INFORMATIONAL';
SELECT DBMS_WARNING.GET_WARNING_SETTING_STRING FROM dual;

--Task 6
SELECT keyword FROM v$reserved_words
WHERE length = 1;

--Task 7
SELECT keyword FROM v$reserved_words
WHERE length > 1 AND keyword != 'A' ORDER BY keyword;

--Task 8
SHOW PARAMETER;
SELECT * FROM v$parameter;

--Task 9
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello World');
END;

--Test 10
DECLARE
n1 NUMBER(1) := 1;
n2 NUMBER := 678;
n3 BINARY_INTEGER := 123.645;
n4 PLS_INTEGER := 123.656; 
n5 NATURAL := 45.67;       
n6 NATURALN := 45.67;
n7 POSITIVE := 45.67;
n8 POSITIVEN := 45.67;
n9 SIGNTYPE := 0;         
BEGIN
DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
DBMS_OUTPUT.PUT_LINE('n2 = ' || n2);
DBMS_OUTPUT.PUT_LINE('n3 = ' || n3);
DBMS_OUTPUT.PUT_LINE('n4 = ' || n4);
DBMS_OUTPUT.PUT_LINE('n5 = ' || n5);
DBMS_OUTPUT.PUT_LINE('n6 = ' || n6);
DBMS_OUTPUT.PUT_LINE('n7 = ' || n7);
DBMS_OUTPUT.PUT_LINE('n8 = ' || n8);
DBMS_OUTPUT.PUT_LINE('n9 = ' || n9);
END;

--Task 11
DECLARE
n1 NUMBER := 5;
n2 NUMBER := 25;
BEGIN
DBMS_OUTPUT.PUT_LINE('n2 / n1 = ' || (n2 / n1));
END;

--Task 12 & 13
DECLARE
n NUMBER := 1234.5678;
n1 NUMBER(3,2) := 3.14;
n2 NUMBER(5,3) := 12.345;
n3 NUMBER(4,-2) := 160.65768;
BEGIN
DBMS_OUTPUT.PUT_LINE('n = ' || n);
DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
DBMS_OUTPUT.PUT_LINE('n2 = ' || n2);
DBMS_OUTPUT.PUT_LINE('n3 = ' || n3);
END;

--Task 14 & 15
DECLARE 
n1 BINARY_FLOAT := 12345.6789;
n2 BINARY_DOUBLE := 123456.789;
BEGIN
DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
DBMS_OUTPUT.PUT_LINE('n2 = ' || n2);
END;

--Task 16
DECLARE
n1 NUMBER := 127E-2;
BEGIN
DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
END;

--Task 17
DECLARE 
b1 BOOLEAN := true;
b2 BOOLEAN := false;
b3 BOOLEAN;
BEGIN
IF b1 THEN DBMS_OUTPUT.PUT_LINE('b1 = ' || 'true'); END IF;
IF NOT b2 AND b2 IS NOT NULL THEN DBMS_OUTPUT.PUT_LINE('b2 = ' || 'false'); END IF;
IF b3 IS NULL THEN DBMS_OUTPUT.PUT_LINE('b3 = ' || 'null'); END IF;
END;

--Task 18
DECLARE
curr_year CONSTANT NUMBER := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
vc CONSTANT VARCHAR2(10) := 'Varchar2';
c CHAR(5) := 'Char';
BEGIN
--curr_year := 2018;
--vc := 'Nvarchar2';
c := 'Nchar';
DBMS_OUTPUT.PUT_LINE(curr_year); 
DBMS_OUTPUT.PUT_LINE(vc); 
DBMS_OUTPUT.PUT_LINE(c); 
EXCEPTION
  WHEN OTHERS
  THEN DBMS_OUTPUT.PUT_LINE('error = ' || sqlerrm);
END;

--Task 19
DECLARE
pulp pulpit.pulpit%TYPE;
BEGIN 
pulp := 'ПОИТ';
DBMS_OUTPUT.PUT_LINE(pulp);
END;

--Task 20
DECLARE
faculty_res faculty%ROWTYPE;
BEGIN 
faculty_res.faculty := 'ФИТ';
faculty_res.faculty_name := 'Факультет информационных технологий';
DBMS_OUTPUT.PUT_LINE(faculty_res.faculty);
END;

--Task 21 & 22
DECLARE 
x PLS_INTEGER := 16;
BEGIN
IF 5 > x THEN
DBMS_OUTPUT.PUT_LINE('5 > '|| x);
ELSIF 5 < x THEN
DBMS_OUTPUT.PUT_LINE('5 < '|| x);
ELSE
DBMS_OUTPUT.PUT_LINE('5 = '|| x);
END IF;
END;

--Task 23
DECLARE 
x PLS_INTEGER := 21;
BEGIN
CASE
WHEN x BETWEEN 10 AND 20 THEN
DBMS_OUTPUT.PUT_LINE('10 <= ' || x || ' <= 20');
WHEN x BETWEEN 21 AND 40 THEN
DBMS_OUTPUT.PUT_LINE('GFFGFG');
ELSE
DBMS_OUTPUT.PUT_LINE('GFGDFGFDGDFGFDGDFGDFGFG');
END CASE;
END;

--Task 24 & 25 & 26
DECLARE 
x PLS_INTEGER := 0;
BEGIN
DBMS_OUTPUT.PUT_LINE('LOOP: ');
LOOP
x := x + 1;
DBMS_OUTPUT.PUT_LINE(x);
EXIT WHEN x >= 3;
END LOOP;

DBMS_OUTPUT.PUT_LINE('FOR: ');
FOR k IN 1..3
LOOP
DBMS_OUTPUT.PUT_LINE(k);
END LOOP;

DBMS_OUTPUT.PUT_LINE('WHILE: ');
WHILE (x > 0)
LOOP
x := x - 1;
DBMS_OUTPUT.PUT_LINE(x);
END LOOP;
END;