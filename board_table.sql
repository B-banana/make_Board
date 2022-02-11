drop SEQUENCE board_seq;

CREATE SEQUENCE board_seq
start with 1
increment by 1
minvalue 1
maxvalue 1000;

drop table board;

create table board(
num NUMBER not null primary key,
writer Varchar2(40),
email varchar2(50),
subject varchar2(50),
password varchar2(50),
reg_date date,
ref number,
re_step number,
re_level number,
readcount number,
content varchar2(50)
);

SELECT
    * FROM
    board;
    
SELECT count(*) FROM board;

SELECT A.* ,Rownum Rnum 
FROM (SELECT * FROM board ORDER BY ref desc, re_step asc) A) 
WHERE Rnum >= ? and Rnum <= ?

insert into board(num, writer, email, subject, password, reg_date, ref, re_step, re_level, readcount, content) 
values(board_seq.nextval, ?, ?, ?, ?, sysdate, ?, ?, ?, 0, ?);

select max(ref) from board;

commit;

select * from board where num = 1;

update board set readcount=readcount+1 where num = 1;

update board set writer = ?, email = ?, subject = ?, password = ?, reg_date = sysdate,content = ?;


