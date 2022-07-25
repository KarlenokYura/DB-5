--PULPITS

create table pulpits (
  pulpit_id number(5) generated as identity (start with 1 increment by 1),
  pulpit_code nvarchar2(6) not null unique,
  pulpit_name nvarchar2(100) default 'Pulpit' not null,
  constraint pulpit_pk primary key (pulpit_id)
);

drop table pulpits;

insert into pulpits(pulpit_code, pulpit_name) values ('����', '��� ���� � ���');
insert into pulpits(pulpit_code) values ('��');
insert into pulpits(pulpit_code, pulpit_name) values ('��', '��� ������');
insert into pulpits(pulpit_code, pulpit_name) values ('��', '���� ���');

select * from pulpits;

update pulpits set pulpit_name = '���� ���' where pulpit_id = 2;

--TEACHERS

create table teachers (
  teacher_id number(5) generated as identity(start with 1 increment by 1),
  teacher_code nvarchar2(6) not null unique,
  teacher_name nvarchar2(15) not null,
  teacher_birthday date not null,
  teacher_salary number(5, 2) not null,
  teacher_sex char(1) default 'M' check (teacher_sex in ('M', 'F')),
  teacher_pulpit nvarchar2(6) not null,
  constraint teacher_pf primary key (teacher_id),
  constraint teacher_pulpit_fk foreign key (teacher_pulpit) references pulpits(pulpit_code)
);

drop table teachers;

insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary) values ('����', '������', '����', '01-01-2020', 200.5);
insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary, teacher_sex) values ('����', '�������', '����', '02-02-2020', 199.99, 'F');
insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary) values ('���', '�����', '��', '03-03-2020', 201.5);
insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary) values ('����', '���������', '��', '04-04-2020', 4.2);
insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary, teacher_sex) values ('����', '����������', '��', '05-05-2020', 999.99, 'F');
insert into teachers (teacher_code, teacher_name, teacher_pulpit, teacher_birthday, teacher_salary) values ('���', '����', '��', '06-06-2020', 0.2);

select * from teachers;

--SUBJECTS

create table subjects (
  subject_id number(5) generated as identity(start with 1 increment by 1),
  subject_code nvarchar2(6) not null unique,
  subject_name nvarchar2(50) not null,
  subject_teacher nvarchar2(6) not null,
  constraint subject_pk primary key (subject_id),
  constraint subject_teacher_fk foreign key (subject_teacher) references teachers (teacher_code)
)

insert into subjects (subject_code, subject_name, subject_teacher) values ('����', '���� ���� ����� ����', '����');
insert into subjects (subject_code, subject_name, subject_teacher) values ('��', '���� ������', '����');
insert into subjects (subject_code, subject_name, subject_teacher) values ('����', '���� � ��� ��� ����', '���');
insert into subjects (subject_code, subject_name, subject_teacher) values ('���', '���� ���� � ����', '����');
insert into subjects (subject_code, subject_name, subject_teacher) values ('��', '��� ����', '���');
commit;

select * from subjects;

drop table subjects;
