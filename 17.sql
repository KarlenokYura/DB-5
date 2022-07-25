--JOB
 
ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 20;
 
CREATE TABLE t_job1 (
  t_number NUMBER,
  t_str VARCHAR2(50)
);

CREATE TABLE t_job2 (
  t_number NUMBER,
  t_str VARCHAR2(50)
);

CREATE OR REPLACE PROCEDURE job_copy 
IS
  CURSOR curs_job IS SELECT * FROM t_job1 WHERE t_number > 10;
BEGIN 
  FOR n IN curs_job
  LOOP
    INSERT INTO t_job2 (t_number, t_str) VALUES (n.t_number, n.t_str); 
  END LOOP;
  DELETE FROM t_job1 WHERE t_number > 10;
END;

INSERT INTO t_job1 (t_number, t_str) VALUES (5, 'ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (10, 'ÄÅÑßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (15, 'ÏßÒÍÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (20, 'ÄÂÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (25, 'ÄÂÀÄÖÀÒÜ ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (30, 'ÒÐÈÄÖÀÒÜ');

SELECT * FROM t_job1;
SELECT * FROM t_job2;

DROP TABLE t_job1;
DROP TABLE t_job2;

BEGIN
job_copy;
END;

ROLLBACK;

--ISUBMIT

DECLARE job_number user_jobs.job%TYPE;
BEGIN
  DBMS_JOB.ISUBMIT(1605, 'BEGIN job_copy; COMMIT; END;', SYSDATE, 'SYSDATE + 1/1440');
  COMMIT;
  SELECT JOB INTO job_number FROM user_jobs;
  SYS.DBMS_OUTPUT.PUT_LINE(job_number);
END;

--RUN

DECLARE job_number user_jobs.job%TYPE;
BEGIN
  DBMS_JOB.RUN(1605);
  COMMIT;
  SELECT JOB INTO job_number FROM user_jobs;
  SYS.DBMS_OUTPUT.PUT_LINE(job_number);
END;

--CHANGE

BEGIN
  DBMS_JOB.CHANGE(1605, NULL, NULL, 'SYSDATE + 1/1440');
  COMMIT;
END;

--NEXT_DATE

BEGIN
  DBMS_JOB.NEXT_DATE(1605, SYSDATE + 1/1440);
  DBMS_JOB.INTERVAL(1605, SYSDATE + 3);
  COMMIT;
END;

--BROKEN

BEGIN
  DBMS_JOB.BROKEN(1605, TRUE, NULL);
  COMMIT;
END;

BEGIN
  DBMS_JOB.REMOVE(1605);
END;

SELECT * FROM user_jobs;

--SCHEDULER

INSERT INTO t_job1 (t_number, t_str) VALUES (5, 'ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (10, 'ÄÅÑßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (15, 'ÏßÒÍÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (20, 'ÄÂÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (25, 'ÄÂÀÄÖÀÒÜ ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (30, 'ÒÐÈÄÖÀÒÜ');

SELECT * FROM t_job1;
SELECT * FROM t_job2;

SELECT * FROM user_scheduler_schedules WHERE SCHEDULE_NAME = 'SCH';
SELECT * FROM user_scheduler_programs WHERE PROGRAM_NAME = 'PROG';
SELECT job_name, program_name, schedule_name, start_date, enabled, last_start_date, last_run_duration, next_run_date  FROM user_scheduler_jobs WHERE JOB_NAME = 'JOB2';
SELECT *  FROM user_scheduler_jobs WHERE JOB_NAME = 'JOB2';

BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE(
      SCHEDULE_NAME => 'SCH',
      START_DATE => SYSTIMESTAMP,
      REPEAT_INTERVAL => 'FREQ=MINUTELY; INTERVAL=1',
      COMMENTS => 'SCH'
  );
END;

BEGIN
  DBMS_SCHEDULER.DROP_SCHEDULE('SCH', true);
END;

BEGIN
  DBMS_SCHEDULER.CREATE_PROGRAM(
      PROGRAM_NAME => 'PROG',
      PROGRAM_TYPE => 'PLSQL_BLOCK',
      PROGRAM_ACTION => 'BEGIN DBMS_OUTPUT.PUT_LINE(2); END;',
      NUMBER_OF_ARGUMENTS => 0,
      ENABLED => TRUE,
      COMMENTS => 'PROG'
  );
END;

BEGIN
  DBMS_SCHEDULER.DROP_PROGRAM('PROG', true);
END;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
      JOB_NAME => 'JOB2',
      PROGRAM_NAME => 'PROG',
      SCHEDULE_NAME => 'SCH',
      ENABLED => TRUE
  );
END;

BEGIN
  DBMS_SCHEDULER.DROP_JOB('JOB2', true);
END;

BEGIN
  DBMS_SCHEDULER.RUN_JOB('JOB2');
END;

BEGIN
  DBMS_SCHEDULER.STOP_JOB('JOB2');
END;