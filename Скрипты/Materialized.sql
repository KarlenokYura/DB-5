--TEACHER_VIEW

create materialized view teacher_view 
refresh complete start with to_date(sysdate) next (sysdate + 1/8640)
as select * from teachers;

select * from teacher_view;

drop materialized view teacher_view;

--SUBJECT_VIEW

create materialized view subject_view
refresh complete start with to_date(sysdate) next (sysdate + 1/8640)
as select * from subjects;

select * from subject_view;

drop materialized view subject_view;
