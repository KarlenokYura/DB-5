SET SERVEROUTPUT ON;

--Task 1
--SELECT * FROM faculty;
DECLARE
faculty_rec faculty%rowtype;
BEGIN
SELECT * INTO faculty_rec FROM faculty WHERE LOWER(faculty) = 'хтит';
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 2
DECLARE
faculty_rec faculty%rowtype;
BEGIN
SELECT * INTO faculty_rec FROM faculty;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 3
DECLARE
faculty_rec faculty%rowtype;
BEGIN
SELECT * INTO faculty_rec FROM faculty;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
EXCEPTION
WHEN TOO_MANY_ROWS
THEN DBMS_OUTPUT.PUT_LINE('Результат состоит из нескольких строк (Code: ' || sqlcode || ', Message: ' || sqlerrm || ')');
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 4
DECLARE
found BOOLEAN;
notfound BOOLEAN;
isopen BOOLEAN;
rowcount PLS_INTEGER;
faculty_rec faculty%rowtype;
BEGIN
SELECT * INTO faculty_rec FROM faculty WHERE LOWER(faculty) = 'хтит';
found := sql%found;
notfound := sql%notfound;
isopen := sql%isopen;
rowcount := sql%rowcount;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
IF found THEN DBMS_OUTPUT.PUT_LINE('Found = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Found = FALSE');
END IF;
IF notfound THEN DBMS_OUTPUT.PUT_LINE('Notfound = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Notfound = FALSE');
END IF;
IF isopen THEN DBMS_OUTPUT.PUT_LINE('Isopen = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Isopen = FALSE');
END IF;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || rowcount);
EXCEPTION
WHEN NO_DATA_FOUND
THEN DBMS_OUTPUT.PUT_LINE('Данные не найдены (Code: ' || sqlcode || ', Message: ' || sqlerrm || ')');
WHEN TOO_MANY_ROWS
THEN DBMS_OUTPUT.PUT_LINE('Результат состоит из нескольких строк (Code: ' || sqlcode || ', Message: ' || sqlerrm || ')');
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 5
--SELECT * FROM faculty;
DECLARE
found BOOLEAN;
notfound BOOLEAN;
isopen BOOLEAN;
rowcount PLS_INTEGER;
faculty_rec faculty%rowtype;
BEGIN
UPDATE faculty SET faculty = 'ТОВ', faculty_name = 'Технология органических веществ' WHERE faculty = 'ТОВ';
ROLLBACK;
found := sql%found;
notfound := sql%notfound;
isopen := sql%isopen;
rowcount := sql%rowcount;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
IF found THEN DBMS_OUTPUT.PUT_LINE('Found = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Found = FALSE');
END IF;
IF notfound THEN DBMS_OUTPUT.PUT_LINE('Notfound = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Notfound = FALSE');
END IF;
IF isopen THEN DBMS_OUTPUT.PUT_LINE('Isopen = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Isopen = FALSE');
END IF;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || rowcount);
--COMMIT;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 6
--SELECT * FROM auditorium;
DECLARE
auditorium_rec auditorium%rowtype;
BEGIN
UPDATE auditorium SET auditorium = '206-1', auditorium_capacity = 'пятнадцать' WHERE auditorium = '206-1';
DBMS_OUTPUT.PUT_LINE(auditorium_rec.auditorium || ' ' || auditorium_rec.auditorium_capacity);
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 7 & 8
SELECT * FROM faculty;
DECLARE
found BOOLEAN;
notfound BOOLEAN;
isopen BOOLEAN;
rowcount PLS_INTEGER;
faculty_rec faculty%rowtype;
BEGIN
INSERT INTO faculty(faculty, faculty_name) VALUES ('ИТ', 'Информационных технологий');
ROLLBACK;
found := sql%found;
notfound := sql%notfound;
isopen := sql%isopen;
rowcount := sql%rowcount;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
IF found THEN DBMS_OUTPUT.PUT_LINE('Found = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Found = FALSE');
END IF;
IF notfound THEN DBMS_OUTPUT.PUT_LINE('Notfound = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Notfound = FALSE');
END IF;
IF isopen THEN DBMS_OUTPUT.PUT_LINE('Isopen = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Isopen = FALSE');
END IF;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || rowcount);
--COMMIT;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 9
SELECT * FROM faculty;
DECLARE
found BOOLEAN;
notfound BOOLEAN;
isopen BOOLEAN;
rowcount PLS_INTEGER;
faculty_rec faculty%rowtype;
BEGIN
DELETE faculty WHERE faculty = 'ИТ';
ROLLBACK;
found := sql%found;
notfound := sql%notfound;
isopen := sql%isopen;
rowcount := sql%rowcount;
DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
IF found THEN DBMS_OUTPUT.PUT_LINE('Found = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Found = FALSE');
END IF;
IF notfound THEN DBMS_OUTPUT.PUT_LINE('Notfound = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Notfound = FALSE');
END IF;
IF isopen THEN DBMS_OUTPUT.PUT_LINE('Isopen = TRUE');
ELSE DBMS_OUTPUT.PUT_LINE('Isopen = FALSE');
END IF;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || rowcount);
--COMMIT;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 10
--SELECT * FROM auditorium;
DECLARE
auditorium_rec auditorium%rowtype;
BEGIN
DELETE auditorium WHERE auditorium_capacity = 'пятнадцать' ;
DBMS_OUTPUT.PUT_LINE(auditorium_rec.auditorium || ' ' || auditorium_rec.auditorium_capacity);
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 11
SELECT * FROM teacher;
DECLARE
CURSOR curs_teacher IS SELECT teacher, teacher_name, pulpit FROM teacher;
m_teacher teacher.teacher%type;
m_teacher_name teacher.teacher_name%type;
m_pulpit teacher.pulpit%type;
BEGIN
OPEN curs_teacher;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || curs_teacher%rowcount);
LOOP
FETCH curs_teacher INTO m_teacher, m_teacher_name, m_pulpit;
EXIT WHEN curs_teacher%notfound;
DBMS_OUTPUT.PUT_LINE(' ' || curs_teacher%rowcount || ' ' || m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
END LOOP;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || curs_teacher%rowcount);
CLOSE curs_teacher;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 12
SELECT * FROM subject;
DECLARE
CURSOR curs_subject IS SELECT subject, subject_name, pulpit FROM subject;
rec_subject subject%rowtype;
BEGIN
OPEN curs_subject;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || curs_subject%rowcount);
FETCH curs_subject INTO rec_subject;
WHILE curs_subject%found
LOOP
DBMS_OUTPUT.PUT_LINE(' ' || curs_subject%rowcount || ' ' || rec_subject.subject || ' ' || rec_subject.subject_name || ' ' || rec_subject.pulpit);
FETCH curs_subject INTO rec_subject;
END LOOP;
DBMS_OUTPUT.PUT_LINE('Rowcount = ' || curs_subject%rowcount);
CLOSE curs_subject;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 13
DECLARE 
CURSOR curs_pulpit IS SELECT pulpit.pulpit, teacher.teacher_name
FROM pulpit INNER JOIN teacher ON pulpit.pulpit = teacher.pulpit;
rec_pulpit curs_pulpit%rowtype;
BEGIN
FOR rec_pulpit IN curs_pulpit
LOOP
DBMS_OUTPUT.PUT_LINE(' ' || curs_pulpit%rowcount || ' ' || rec_pulpit.pulpit || ' ' || rec_pulpit.teacher_name);
END LOOP;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 14
--SELECT * FROM auditorium;
DECLARE 
CURSOR curs_auditorium (min_cap auditorium.auditorium_capacity%type, max_cap auditorium.auditorium_capacity%type)
IS SELECT auditorium, auditorium_capacity
FROM auditorium 
WHERE auditorium_capacity >= min_cap AND auditorium_capacity <= max_cap;
BEGIN
FOR rec_auditorium IN curs_auditorium(0,20)
LOOP
DBMS_OUTPUT.PUT_LINE('(0 - 20): ' || rec_auditorium.auditorium || ' ' || rec_auditorium.auditorium_capacity);
END LOOP;
FOR rec_auditorium IN curs_auditorium(21,30)
LOOP
DBMS_OUTPUT.PUT_LINE('(21 - 30): ' || rec_auditorium.auditorium || ' ' || rec_auditorium.auditorium_capacity);
END LOOP;
FOR rec_auditorium IN curs_auditorium(31,60)
LOOP
DBMS_OUTPUT.PUT_LINE('(31 - 60): ' || rec_auditorium.auditorium || ' ' || rec_auditorium.auditorium_capacity);
END LOOP;
FOR rec_auditorium IN curs_auditorium(61,80)
LOOP
DBMS_OUTPUT.PUT_LINE('(61 - 80): ' || rec_auditorium.auditorium || ' ' || rec_auditorium.auditorium_capacity);
END LOOP;
FOR rec_auditorium IN curs_auditorium(81,100)
LOOP
DBMS_OUTPUT.PUT_LINE('(81 - 100): ' || rec_auditorium.auditorium || ' ' || rec_auditorium.auditorium_capacity);
END LOOP;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 15
VARIABLE x refcursor;
DECLARE 
TYPE teacher_name IS REF CURSOR RETURN teacher%rowtype;
xcurs teacher_name;
rec_teacher teacher%rowtype;
BEGIN
OPEN xcurs FOR SELECT * FROM teacher;
:x :=xcurs;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

PRINT x;

--Task 16
DECLARE 
CURSOR curs_aut
IS SELECT auditorium_type,
CURSOR (
SELECT auditorium
FROM auditorium aum
WHERE aut.auditorium_type = aum.auditorium_type
)
FROM auditorium_type aut;
curs_aum SYS_REFCURSOR;
aut auditorium_type.auditorium_type%type;
txt VARCHAR2(1000);
aum auditorium.auditorium%type;
BEGIN
OPEN curs_aut;
FETCH curs_aut INTO aut, curs_aum;
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

--Task 17
SELECT * FROM auditorium;
DECLARE 
CURSOR curs_auditorium(min_cap auditorium.auditorium%type, max_cap auditorium.auditorium%type)
IS SELECT auditorium, auditorium_capacity
FROM auditorium
WHERE auditorium_capacity >= min_cap AND auditorium_capacity <= max_cap FOR UPDATE;
rec_auditorium auditorium.auditorium%type;
rec_auditorium_capacity auditorium.auditorium_capacity%type;
BEGIN
OPEN curs_auditorium(40,80);
FETCH curs_auditorium INTO rec_auditorium, rec_auditorium_capacity;
WHILE(curs_auditorium%found)
LOOP
rec_auditorium_capacity := rec_auditorium_capacity * 0.9;
UPDATE auditorium SET auditorium_capacity = rec_auditorium_capacity
WHERE CURRENT OF curs_auditorium;
DBMS_OUTPUT.PUT_LINE(' ' || rec_auditorium || ' ' || rec_auditorium_capacity);
FETCH curs_auditorium INTO rec_auditorium, rec_auditorium_capacity;
END LOOP;
ROLLBACK;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 18
--SELECT * FROM auditorium;
DECLARE 
CURSOR curs_auditorium(min_cap auditorium.auditorium%type, max_cap auditorium.auditorium%type)
IS SELECT auditorium, auditorium_capacity
FROM auditorium
WHERE auditorium_capacity >= min_cap AND auditorium_capacity <= max_cap FOR UPDATE;
rec_auditorium auditorium.auditorium%type;
rec_auditorium_capacity auditorium.auditorium_capacity%type;
BEGIN
OPEN curs_auditorium(0,20);
FETCH curs_auditorium INTO rec_auditorium, rec_auditorium_capacity;
WHILE(curs_auditorium%found)
LOOP
DELETE auditorium WHERE CURRENT OF curs_auditorium;
FETCH curs_auditorium INTO rec_auditorium, rec_auditorium_capacity;
END LOOP;
CLOSE curs_auditorium;
FOR aud IN curs_auditorium(0,100)
LOOP DBMS_OUTPUT.PUT_LINE(' ' || aud.auditorium || ' ' || aud.auditorium_capacity);
END LOOP;
ROLLBACK;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 19
SELECT * FROM auditorium;
DECLARE
CURSOR curs_auditorium(capacity auditorium.auditorium%type)
IS SELECT auditorium, auditorium_capacity, rowid
FROM auditorium
WHERE auditorium_capacity >= capacity FOR UPDATE;
aum auditorium.auditorium%type;
cty auditorium.auditorium_capacity%type;
BEGIN
FOR xxx IN curs_auditorium(80)
LOOP
CASE
WHEN xxx.auditorium_capacity > 90
THEN DELETE auditorium
WHERE rowid = xxx.rowid;
WHEN xxx.auditorium_capacity >= 80
THEN UPDATE auditorium
SET auditorium_capacity = auditorium_capacity + 3
WHERE rowid = xxx.rowid;
END CASE;
END LOOP;
FOR yyy IN curs_auditorium(80)
LOOP
DBMS_OUTPUT.PUT_LINE(' ' || yyy.auditorium || ' ' || yyy.auditorium_capacity);
END LOOP;
ROLLBACK;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;

--Task 20
DECLARE
CURSOR curs_teacher IS SELECT teacher, teacher_name, pulpit FROM teacher;
i INTEGER := 1;
BEGIN
FOR rec_teacher IN curs_teacher
LOOP
DBMS_OUTPUT.PUT_LINE(' ' || curs_teacher%rowcount || ' ' || rec_teacher.teacher || ' ' || rec_teacher.teacher_name || ' ' || rec_teacher.pulpit);
IF (i mod 3 = 0) THEN DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------'); 
END IF;
i := i + 1;
END LOOP;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('Code: ' || sqlcode || ', Message: ' || sqlerrm);
END;