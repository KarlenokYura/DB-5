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
  CURSOR curs_job IS SELECT * FROM SYS.t_job1 WHERE t_number > 10;
BEGIN 
  FOR n IN curs_job
  LOOP
    INSERT INTO SYS.t_job2 (t_number, t_str) VALUES (n.t_number, n.t_str); 
  END LOOP;
  DELETE FROM SYS.t_job1 WHERE t_number > 10;
  COMMIT;
END job_copy;

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

--SCHEDULER

INSERT INTO t_job1 (t_number, t_str) VALUES (5, 'ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (10, 'ÄÅÑßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (15, 'ÏßÒÍÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (20, 'ÄÂÀÄÖÀÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (25, 'ÄÂÀÄÖÀÒÜ ÏßÒÜ');
INSERT INTO t_job1 (t_number, t_str) VALUES (30, 'ÒÐÈÄÖÀÒÜ');
COMMIT;

SELECT * FROM t_job1;
DELETE t_job1;
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
      END_DATE => NULL,
      COMMENTS => 'SCH'
  );
END;

BEGIN
  DBMS_SCHEDULER.DROP_SCHEDULE('SCH', true);
END;

BEGIN
  DBMS_SCHEDULER.CREATE_PROGRAM(
      PROGRAM_NAME => 'PROG',
      PROGRAM_TYPE => 'STORED_PROCEDURE',
      PROGRAM_ACTION => 'SYS.JOB_COPY',
      NUMBER_OF_ARGUMENTS => 0,
      ENABLED => TRUE,
      COMMENTS => 'PROG'
  );
  DBMS_SCHEDULER.enable (name=>'prog');
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