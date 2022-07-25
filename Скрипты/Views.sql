--PULPIT_TEACHER_VIEW

create view pulpit_teacher_view as select pulpits.pulpit_code, pulpits.pulpit_name, 
teachers.teacher_code, teachers.teacher_name, teachers.teacher_birthday, teachers.teacher_salary, teachers.teacher_sex
from pulpits right join teachers on pulpits.pulpit_code = teachers.teacher_pulpit;

select * from pulpit_teacher_view;

drop view pulpit_teacher_view;

--TEACHER_SUBJECT_VIEW

create view teacher_subject_view as select teachers.teacher_code, teachers.teacher_name, teachers.teacher_birthday, teachers.teacher_salary, teachers.teacher_sex,
subjects.subject_code, subjects.subject_name
from teachers full join subjects on teachers.teacher_code = subjects.subject_teacher;

select * from teacher_subject_view;

drop view teacher_subject_view;