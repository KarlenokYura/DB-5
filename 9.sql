SELECT * FROM dba_ts_quotas;

ALTER USER KYACORE QUOTA UNLIMITED ON TS_KYA;

GRANT CREATE SEQUENCE TO KYACORE;
GRANT SELECT ANY SEQUENCE TO KYACORE;
GRANT CREATE CLUSTER TO KYACORE;
GRANT CREATE SYNONYM TO KYACORE;
GRANT CREATE PUBLIC SYNONYM TO KYACORE;
GRANT DROP PUBLIC SYNONYM TO KYACORE;
GRANT CREATE VIEW TO KYACORE;
GRANT CREATE MATERIALIZED VIEW TO KYACORE;

-----------------------------------------------------------------------------
CREATE SEQUENCE S1
START WITH 1000
INCREMENT BY 10
NOCYCLE
NOORDER
NOCACHE;

SELECT S1.NEXTVAL FROM dual;
SELECT S1.CURRVAL FROM dual;

DROP SEQUENCE S1;
-----------------------------------------------------------------------------
CREATE SEQUENCE S2
START WITH 10
INCREMENT BY 10
MAXVALUE 100
NOCYCLE
NOORDER
NOCACHE;

SELECT S2.NEXTVAL FROM dual;
SELECT S2.CURRVAL FROM dual;

ALTER SEQUENCE S2 INCREMENT BY 90;
ALTER SEQUENCE S2 INCREMENT BY 10;

DROP SEQUENCE S2;
------------------------------------------------------------------------------
CREATE SEQUENCE S3
START WITH 10
INCREMENT BY -10
MINVALUE -100
MAXVALUE 10
NOCYCLE
ORDER
NOCACHE;

SELECT S3.NEXTVAL FROM dual;
SELECT S3.CURRVAL FROM dual;

ALTER SEQUENCE S3 INCREMENT BY 50;
ALTER SEQUENCE S3 INCREMENT BY -10;

DROP SEQUENCE S3;
-------------------------------------------------------------------------------
CREATE SEQUENCE S4
START WITH 1
INCREMENT BY 1
MAXVALUE 10
CYCLE
CACHE 5
NOORDER;

SELECT S4.NEXTVAL FROM dual;
SELECT S4.CURRVAL FROM dual;

DROP SEQUENCE S4;
--------------------------------------------------------------------------------
SELECT * FROM SYS.all_sequences WHERE SEQUENCE_OWNER = 'KYACORE';
--------------------------------------------------------------------------------
CREATE TABLE T1(
    N1 NUMBER(20),
    N2 NUMBER(20),
    N3 NUMBER(20),
    N4 NUMBER(20)
);

ALTER TABLE T1 STORAGE (BUFFER_POOL KEEP);

INSERT INTO T1(N1, N2, N3, N4) VALUES(S1.NEXTVAL, S2.NEXTVAL, S3.NEXTVAL, S4.NEXTVAL);

SELECT * FROM T1;

DROP TABLE T1;
-----------------------------------------------------------------------------
CREATE CLUSTER ABC(
    X NUMBER(10),
    V VARCHAR2(12)
)
HASHKEYS 200;

SELECT * FROM all_clusters WHERE OWNER = 'KYACORE';
SELECT * FROM dba_segments WHERE OWNER = 'KYACORE';

DROP CLUSTER ABC;
-----------------------------------------------------------------------------
CREATE TABLE A(
    XA NUMBER(10),
    VA VARCHAR2(12)
)
CLUSTER ABC(XA, VA);

CREATE TABLE B(
    XB NUMBER(10),
    VB VARCHAR2(12)
)
CLUSTER ABC(XB, VB);

CREATE TABLE C(
    XC NUMBER(10),
    VC VARCHAR2(12)
)
CLUSTER ABC(XC, VC);

SELECT * FROM all_tables WHERE OWNER = 'KYACORE';

DROP TABLE A;
DROP TABLE B;
DROP TABLE C;
-----------------------------------------------------------------------------
CREATE SYNONYM SYN1 FOR KYACORE.A;

SELECT * FROM SYN1;

DROP SYNONYM SYN1;
-----------------------------------------------------------------------------
CREATE PUBLIC SYNONYM SYN2 FOR KYACORE.A;

SELECT * FROM SYN2;

DROP PUBLIC SYNONYM SYN2;
----------------------------------------------------------------------------
CREATE TABLE A(
    XA NUMBER(10),
    VA VARCHAR2(12),
    PRIMARY KEY (XA)
);

CREATE TABLE B(
    XB NUMBER(10),
    VB VARCHAR2(12),
    XA NUMBER(10),
    PRIMARY KEY (XB)
);

ALTER TABLE B
ADD CONSTRAINT fk_b_a
FOREIGN KEY (XA)
REFERENCES A(XA);

INSERT INTO A(XA,VA) VALUES(1,'ÎÄÈÍ');
INSERT INTO A(XA,VA) VALUES(2,'ÄÂÀ');
INSERT INTO A(XA,VA) VALUES(3,'ÒÐÈ');

INSERT INTO B(XB,VB,XA) VALUES(1,'ONE',1);
INSERT INTO B(XB,VB,XA) VALUES(2,'TWO',2);
INSERT INTO B(XB,VB,XA) VALUES(3,'THREE',3);

DROP TABLE A;
DROP TABLE B;

----------------------------------------------------------------------------
SELECT * FROM A;
SELECT * FROM B;
----------------------------------------------------------------------------

CREATE VIEW V1 AS SELECT ta.XA, ta.VA, tb.VB
FROM A ta INNER JOIN B tb ON ta.XA = tb.XA; 

SELECT * FROM V1;

DROP VIEW V1;

-------------------------------------------------------------------------------------------------------------
CREATE MATERIALIZED VIEW MV
BUILD IMMEDIATE
REFRESH COMPLETE START WITH TO_DATE(sysdate) NEXT (sysdate+2/1440)
AS SELECT ta.XA, ta.VA, tb.VB
FROM A ta INNER JOIN B tb ON ta.XA = tb.XA;

COMMIT;

SELECT * FROM A;
SELECT * FROM B;
SELECT * FROM MV;

INSERT INTO A(XA,VA) VALUES(4,'×ÅÒÛÐÅ');
INSERT INTO B(XB,VB,XA) VALUES(4,'FOUR',4);

DROP MATERIALIZED VIEW MV;



