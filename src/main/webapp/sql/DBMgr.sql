

-- ctrl + a (전체선택) 후 ctrl + shift + enter  => 쿼리문 전체 실행

USE MillkyWayDB;

show tables;

select * from membertbl;

-- partnertbl;

select * from booktbl;

select * from boardtbl;

select * from reviewtbl;

select * from purchasetbl;

select * from wishtbl;

select * from carttbl;

select * from canceltbl;

select * from commenttbl;

select count(*) from carttbl;

SELECT photo FROM Booktbl WHERE bookid = 1;

select bookid,miniIntro,author,title from booktbl;

select content,ref from boardtbl limit 10;

select content,ref,liked from boardtbl order by liked desc limit 10;

-- delete from boardtbl where boardid > 0; 
delete from membertbl where userid = 1; 
drop tables boardtbl;

select count(*) from wishtbl WHERE userid = 3;

SHOW VARIABLES LIKE 'secure_file_priv';











