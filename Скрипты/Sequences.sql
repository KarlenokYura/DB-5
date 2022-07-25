--S1

create sequence s1
start with 1000
increment by 10
nocycle
nocache
noorder;

select s1.nextval from dual;
select s1.currval from dual;

drop sequence s1;

--S2

create sequence s2
start with 10
increment by 10
maxvalue 100
nocycle
nocache;

select s2.nextval from dual;

drop sequence s2;

--S3

create sequence s3
start with 10
increment by -10
maxvalue 10
minvalue -100
nocycle
order;

select s3.nextval from dual;

drop sequence s3;

--S4

create sequence s4
start with 1
increment by 1
maxvalue 10
minvalue 1
cycle
cache 5
noorder;

select s4.nextval from dual;

drop sequence s4;
