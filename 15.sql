--Task 1

CREATE TABLE tab(
tab_id NUMBER(10) GENERATED AS IDENTITY(START with 1 INCREMENT by 1),
tab_name VARCHAR2(30) NOT NULL,
CONSTRAINT tab_pk PRIMARY KEY (tab_id)
);

DROP TABLE tab;

--Task 2

DECLARE
    i int := 1;
BEGIN
    WHILE i < 11
    LOOP
    INSERT INTO tab(tab_name) VALUES (concat('Row ', TO_CHAR(i)));
    i := i + 1;
    END LOOP;
END;

SELECT * FROM tab;

--Task 3 & 4

CREATE OR REPLACE TRIGGER bi_trigger
BEFORE INSERT ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before insert trigger');
END;

CREATE OR REPLACE TRIGGER bd_trigger
BEFORE DELETE ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before delete trigger');
END;

CREATE OR REPLACE TRIGGER bu_trigger
BEFORE UPDATE ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before update trigger');
END;

DROP TRIGGER bi_trigger;
DROP TRIGGER bd_trigger;
DROP TRIGGER bu_trigger;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

--Task 5

CREATE OR REPLACE TRIGGER bi_trigger_r
BEFORE INSERT ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before insert trigger for each row');
END;

CREATE OR REPLACE TRIGGER bd_trigger_r
BEFORE DELETE ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before delete trigger for each row');
END;

CREATE OR REPLACE TRIGGER bu_trigger_r
BEFORE UPDATE ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before update trigger for each row');
END;

DROP TRIGGER bi_trigger_r;
DROP TRIGGER bd_trigger_r;
DROP TRIGGER bu_trigger_r;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

--Task 6

CREATE OR REPLACE TRIGGER idu_trigger
BEFORE INSERT OR UPDATE OR DELETE ON tab
BEGIN
IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Before insert trigger');
ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Before delete trigger');
ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Before update trigger');
END IF;
END;

DROP TRIGGER idu_trigger;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

--Task 7

CREATE OR REPLACE TRIGGER ai_trigger
AFTER INSERT ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('After insert trigger');
END;

CREATE OR REPLACE TRIGGER ad_trigger
AFTER DELETE ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('After delete trigger');
END;

CREATE OR REPLACE TRIGGER au_trigger
AFTER UPDATE ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('After update trigger');
END;

DROP TRIGGER ai_trigger;
DROP TRIGGER ad_trigger;
DROP TRIGGER au_trigger;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

--Task 8

CREATE OR REPLACE TRIGGER ai_trigger_r
AFTER INSERT ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('After insert trigger for each row');
END;

CREATE OR REPLACE TRIGGER ad_trigger_r
AFTER DELETE ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('After delete trigger for each row');
END;

CREATE OR REPLACE TRIGGER au_trigger_r
AFTER UPDATE ON tab FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('After update trigger for each row');
END;

DROP TRIGGER ai_trigger_r;
DROP TRIGGER ad_trigger_r;
DROP TRIGGER au_trigger_r;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

--Task 9

CREATE TABLE AUDITS(OperationDate DATE, OperationType VARCHAR2(40), TriggerName VARCHAR2(40), Datum VARCHAR2(40));

DROP TABLE AUDITS;

--Task 10

CREATE OR REPLACE TRIGGER b_audits_trigger
BEFORE INSERT OR UPDATE OR DELETE ON tab
BEGIN
IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Before insert trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Insert', 'b_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Before delete trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Delete', 'b_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Before update trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Update', 'b_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
END IF;
END;

CREATE OR REPLACE TRIGGER a_audits_trigger
AFTER INSERT OR UPDATE OR DELETE ON tab
BEGIN
IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('After insert trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Insert', 'a_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('After delete trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Delete', 'a_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('After update trigger for AUDITS');
    INSERT INTO audits(OperationDate, OperationType, TriggerName, Datum)
    SELECT sysdate, 'Update', 'a_audits_trigger', concat(tab.tab_id, tab.tab_name) FROM tab;
END IF;
END;

INSERT INTO tab(tab_name) VALUES ('Row 11');
UPDATE tab SET tab_name = 'Row 12' WHERE tab_name = 'Row 11';
DELETE tab WHERE tab_name = 'Row 12';

SELECT * FROM audits;

DROP TRIGGER b_audits_trigger;
DROP TRIGGER a_audits_trigger;

--Task 11

CREATE OR REPLACE TRIGGER ci_trigger
BEFORE INSERT ON tab
BEGIN
    INSERT INTO tab(tab_id, tab_name) VALUES (11, 'Row 11');
END;

DROP TRIGGER ci_trigger;

INSERT INTO tab(tab_name) VALUES ('Row 11');

--Task 12

DROP TABLE tab;
FLASHBACK TABLE tab TO BEFORE DROP;

--Task 13

CREATE OR REPLACE TRIGGER drop_trigger
BEFORE DROP ON GAMEDBADMIN.SCHEMA
BEGIN
    RAISE_APPLICATION_ERROR (-20228, 'Doesnt drop table, please!');
END; 

DROP TRIGGER drop_trigger;

--Task 14

CREATE VIEW tabview AS 
SELECT * FROM tab;

SELECT * FROM tabview;

DROP VIEW tabview;

CREATE OR REPLACE TRIGGER instead_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE ON tabview
BEGIN
IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE(:new.tab_name);
    INSERT INTO tab(tab_name) VALUES ('Insert');
ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Delete');
ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Update');
END if;
END instead_trigger;

INSERT INTO tabview(tab_name) VALUES ('Something');
DELETE tabview WHERE tab_name = 'Insert';

DELETE tab WHERE tab_name = 'Insert';

DROP TRIGGER instead_trigger;

--Task 15


CREATE OR REPLACE custom_trigger
BEFORE UPDATE ON tab
BEGIN
    UPDATE SET tab_name = new:tab.tab_name WHERE tab_name != new:tab.tab_name;
END custom_trigger;

CREATE OR REPLACE TRIGGER custom_trigger
BEFORE UPDATE ON tab
BEGIN
    DBMS_OUTPUT.PUT_LINE('After insert trigger for each row');
END;

