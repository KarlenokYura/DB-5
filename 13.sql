GRANT CREATE PROCEDURE TO KYACORE;
GRANT CREATE TABLE TO KYACORE;

--Task 1 local

DECLARE
    PROCEDURE get_teachers
        (pcode IN sys.teacher.pulpit%TYPE)
    IS
        CURSOR curs_teacher IS SELECT teacher_name, teacher FROM teacher WHERE UPPER(pulpit) = UPPER(pcode);
        m_teacher_name teacher.teacher_name%type;
        m_teacher teacher.teacher%type;
    BEGIN
        OPEN curs_teacher;
        FETCH curs_teacher INTO m_teacher_name, m_teacher;
        LOOP
            DBMS_OUTPUT.PUT_LINE(curs_teacher%rowcount || ' ' || m_teacher_name || ' ' || m_teacher);
            FETCH curs_teacher INTO m_teacher_name, m_teacher;
            EXIT WHEN curs_teacher%notfound;
        END LOOP;
        CLOSE curs_teacher;
    END get_teachers;
BEGIN
    get_teachers('исит');
END;

--Task 1

CREATE OR REPLACE PROCEDURE get_teachers
    (pcode IN sys.teacher.pulpit%TYPE)
IS
    CURSOR curs_teacher IS SELECT teacher_name, teacher FROM teacher WHERE UPPER(pulpit) = UPPER(pcode);
    m_teacher_name teacher.teacher_name%type;
    m_teacher teacher.teacher%type;
BEGIN
    OPEN curs_teacher;
    FETCH curs_teacher INTO m_teacher_name, m_teacher;
    LOOP
        DBMS_OUTPUT.PUT_LINE(curs_teacher%rowcount || ' ' || m_teacher_name || ' ' || m_teacher);
        FETCH curs_teacher INTO m_teacher_name, m_teacher;
        EXIT WHEN curs_teacher%notfound;
    END LOOP;
    CLOSE curs_teacher;
END get_teachers;

BEGIN
get_teachers('исит');
END;

DROP PROCEDURE get_teachers;

--Task 2 local

DECLARE
    FUNCTION get_num_teachers
        (pcode IN teacher.pulpit%TYPE)
        RETURN NUMBER
    IS
        cnt NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM teacher WHERE UPPER(pulpit) = UPPER(pcode);
    RETURN cnt;
    END get_num_teachers;
BEGIN
    DBMS_OUTPUT.PUT_LINE(get_num_teachers('исит'));
END;

--Task 2

CREATE OR REPLACE FUNCTION get_num_teachers
    (pcode IN teacher.pulpit%TYPE)
    RETURN NUMBER
IS
    cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO cnt FROM teacher WHERE UPPER(pulpit) = UPPER(pcode);
RETURN cnt;
END get_num_teachers;

BEGIN
DBMS_OUTPUT.PUT_LINE(get_num_teachers('исит'));
END;

DROP FUNCTION get_num_teachers;

--Task 3

CREATE OR REPLACE PROCEDURE get_subjects
    (pcode IN subject.pulpit%TYPE)
IS
    CURSOR curs_subject IS SELECT subject_name, subject FROM subject WHERE UPPER(pulpit) = UPPER(pcode);
    m_subject_name subject.subject_name%type;
    m_subject subject.subject%type;
BEGIN
    OPEN curs_subject;
    FETCH curs_subject INTO m_subject_name, m_subject;
    LOOP
        DBMS_OUTPUT.PUT_LINE(curs_subject%rowcount || ' ' || m_subject_name || ' ' || m_subject);
        FETCH curs_subject INTO m_subject_name, m_subject;
        EXIT WHEN curs_subject%notfound;
    END LOOP;
    CLOSE curs_subject;
END get_subjects;

BEGIN
get_subjects('исит');
END;

DROP PROCEDURE get_subjects;

--Task 4

CREATE OR REPLACE FUNCTION get_num_subjects
    (pcode IN subject.pulpit%TYPE)
    RETURN NUMBER
IS
    cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO cnt FROM subject WHERE UPPER(pulpit) = UPPER(pcode);
RETURN cnt;
END get_num_subjects;

BEGIN
DBMS_OUTPUT.PUT_LINE(get_num_subjects('исит'));
END;

DROP FUNCTION get_num_subjects;

--Task 5

CREATE OR REPLACE PACKAGE teachers AS
    PROCEDURE get_subjects
    (pcode IN subject.pulpit%TYPE);

    FUNCTION get_num_subjects
    (pcode IN subject.pulpit%TYPE)
    RETURN NUMBER;
END teachers;

CREATE OR REPLACE PACKAGE BODY teachers AS
    PROCEDURE get_subjects
    (pcode IN subject.pulpit%TYPE)
    IS
        CURSOR curs_subject IS SELECT subject_name, subject FROM subject WHERE UPPER(pulpit) = UPPER(pcode);
        m_subject_name subject.subject_name%type;
        m_subject subject.subject%type;
    BEGIN
        OPEN curs_subject;
        FETCH curs_subject INTO m_subject_name, m_subject;
        LOOP
            DBMS_OUTPUT.PUT_LINE(curs_subject%rowcount || ' ' || m_subject_name || ' ' || m_subject);
            FETCH curs_subject INTO m_subject_name, m_subject;
            EXIT WHEN curs_subject%notfound;
        END LOOP;
        CLOSE curs_subject;
    END get_subjects;

    FUNCTION get_num_subjects
        (pcode IN subject.pulpit%TYPE)
        RETURN NUMBER
    IS
        cnt NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM subject WHERE UPPER(pulpit) = UPPER(pcode);
    RETURN cnt;
    END get_num_subjects;
END teachers;

BEGIN
teachers.get_subjects('исит');
DBMS_OUTPUT.PUT_LINE('¬сего: ' || teachers.get_num_subjects('исит'));
END;

DROP PACKAGE teachers;

