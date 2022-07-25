--Task 1

ALTER TABLE TEACHER ADD BIRTHDAY DATE;

UPDATE TEACHER
SET BIRTHDAY='18.11.2019'
WHERE TEACHER='—ÃÀ¬';

UPDATE TEACHER
SET BIRTHDAY='20.12.2019'
WHERE TEACHER='¿ Õ¬◊';

UPDATE TEACHER
SET BIRTHDAY='25.11.2010'
WHERE TEACHER=' À—Õ¬';

--Task 2

SELECT * FROM TEACHER;

--Task 3
SELECT * FROM TEACHER WHERE TO_CHAR(BIRTHDAY, 'DAY') = 'œŒÕ≈ƒ≈À‹Õ» ';

--Task 4

CREATE VIEW NextMonthBirth AS SELECT * FROM TEACHER WHERE TO_CHAR(sysdate,'mm')+1 = TO_CHAR(BIRTHDAY, 'mm');
SELECT * FROM NextMonthBirth;
DROP NextMonthBirth;

--Task 5

CREATE VIEW NumberTeachersMonths AS SELECT to_char(TBIRTHDAY, 'Month', 'nls_date_language=russian') Ã≈—ﬂ÷, to_char(TBIRTHDAY, 'yyyy') √Œƒ, count(*)  ŒÀ¬Œ
FROM (SELECT TRUNC(BIRTHDAY, 'MM') AS TBIRTHDAY FROM TEACHER ) GROUP BY TBIRTHDAY ORDER BY TBIRTHDAY;
SELECT * FROM NumberTeachersMonths;
DROP VIEW NumberTeachersMonths;

--Task 6

DECLARE 
CURSOR curs_jubilee IS SELECT * FROM TEACHER WHERE MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(BIRTHDAY, 'yyyy')+1), 10) = 0;
rec_jubilee curs_jubilee%ROWTYPE;
BEGIN
FOR rec_jubilee IN curs_jubilee
LOOP
DBMS_OUTPUT.PUT_LINE(' ' || curs_jubilee%rowcount || ' ' || rec_jubilee.teacher_name || ' ' || rec_jubilee.birthday);
END LOOP;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;
    
--Task 7

ALTER TABLE TEACHER ADD SALARY NUMBER;

UPDATE TEACHER
SET SALARY=2000
WHERE TEACHER='—ÃÀ¬';

UPDATE TEACHER
SET SALARY=1800
WHERE TEACHER='¿ Õ¬◊';

UPDATE TEACHER
SET SALARY=1200
WHERE TEACHER=' À—Õ¬';

DECLARE
CURSOR curs_avg IS SELECT PULPIT, FLOOR(AVG(SALARY)) FROM TEACHER GROUP BY PULPIT;
m_pulpit teacher.pulpit%TYPE;
m_avg_salary teacher.salary%TYPE;
BEGIN
OPEN curs_avg;
LOOP
FETCH curs_avg INTO m_pulpit, m_avg_salary;
EXIT WHEN curs_avg%notfound;
DBMS_OUTPUT.PUT_LINE(' ' || curs_avg%rowcount || ' ' || m_pulpit || ' ' || m_avg_salary);
END LOOP;
CLOSE curs_avg;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

DECLARE
CURSOR curs_avg IS SELECT PULPIT.FACULTY, ROUND(AVG(TEACHER.SALARY),3) FROM TEACHER INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT GROUP BY PULPIT.FACULTY;
m_faculty pulpit.faculty%TYPE;
m_avg_salary teacher.salary%TYPE;
BEGIN
OPEN curs_avg;
LOOP
FETCH curs_avg INTO m_faculty, m_avg_salary;
EXIT WHEN curs_avg%notfound;
DBMS_OUTPUT.PUT_LINE(' ' || curs_avg%rowcount || ' ' || m_faculty || ' ' || m_avg_salary);
END LOOP;
CLOSE curs_avg;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

DECLARE
CURSOR curs_avg IS SELECT ROUND(AVG(SALARY),3) FROM TEACHER;
m_avg_salary teacher.salary%TYPE;
BEGIN
OPEN curs_avg;
LOOP
FETCH curs_avg INTO m_avg_salary;
EXIT WHEN curs_avg%notfound;
DBMS_OUTPUT.PUT_LINE(' ' || m_avg_salary);
END LOOP;
CLOSE curs_avg;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 8

DECLARE
  TYPE PERSON IS RECORD
    (
      NAME NVARCHAR2(50),
      PULPIT NVARCHAR2(50)
    );
  rec PERSON;
BEGIN
  SELECT TEACHER_NAME, PULPIT INTO rec FROM TEACHER WHERE TEACHER='∆À ';
  DBMS_OUTPUT.PUT_LINE(rec.PULPIT || ' ' || rec.NAME);
END;

DECLARE
    TYPE ADDRESS IS RECORD
    (
      TOWN NVARCHAR2(50),
      COUNTRY NVARCHAR2(50)
    );
    TYPE PERSON IS RECORD
    (
      PULPIT TEACHER.PULPIT%TYPE,
      NAME TEACHER.TEACHER_NAME%TYPE,
      homeAddress ADDRESS
    );
  rec PERSON;
  rec2 PERSON;
BEGIN
  SELECT TEACHER_NAME, PULPIT INTO rec.NAME, rec.PULPIT FROM TEACHER WHERE TEACHER='–ÃÕ ';
  rec.homeAddress.TOWN := 'MINSK';
  rec.homeAddress.COUNTRY := 'BELARUS';
  rec2 := rec;
  DBMS_OUTPUT.PUT_LINE(rec2.PULPIT || '  ' || rec2.NAME || ' ' || rec2.homeAddress.TOWN || ' ' || rec2.homeAddress.COUNTRY);
END;

SELECT * FROM PULPIT;
SELECT * FROM TEACHER;

--Cursor
DECLARE 
    CURSOR curs_avg IS SELECT pulpit, CURSOR (
        SELECT faculty FROM pulpit fac WHERE tea.pulpit = pul.pulpit
    )
    FROM teacher tea;
    curs_fac SYS_REFCURSOR;
    tea teacher.pulpit%type;
    txt VARCHAR2(1000);
    pul pulpit.pulpit%type;
BEGIN
    OPEN curs_avg;
    FETCH curs_avg INTO aut, curs_aum;
    WHILE (curs_aut%found)
    LOOP
    txt:=RTRIM(aut) || ':';
    LOOP
    FETCH curs_aum INTO aum;
    EXIT WHEN curs_aum%notfound;
    txt := txt || ',' || RTRIM(aum);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(txt);
    FETCH curs_aut INTO aut, curs_aum;
    END LOOP;
CLOSE curs_aut;
EXCEPTION
    WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;