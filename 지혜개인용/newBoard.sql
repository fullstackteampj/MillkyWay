USE millkywaydb;
SHOW tables;

DROP TABLE IF EXISTS boardtbl;
DROP TABLE IF EXISTS commenttbl;
DROP TABLE IF EXISTS categoryForAdmintbl;
DROP TABLE IF EXISTS tabForAdmintbl;
DROP TABLE IF EXISTS likedtbl;


### 테이블 생성
-- 게시글 테이블 생성
CREATE TABLE boardtbl (
    boardid INT PRIMARY KEY AUTO_INCREMENT,					-- 게시물 ID, 기본 키 및 자동 증가
    userid INT NOT NULL,                            		-- 작성자 ID(식별자)
    nickname VARCHAR(100) NOT NULL,                         -- 작성자 닉네임
    title VARCHAR(200) NOT NULL,                            -- 게시물 제목
    content TEXT NOT NULL,                                  -- 게시물 내용
    photo MEDIUMBLOB,                               	 	-- 게시물에 포함된 사진
    genre VARCHAR(50) NOT NULL,                             -- 도서 장르 (문학, 인문학, 에세이, 자기계발, 경제경영, 과학, 사회과학, 역사, 종교, 만화, 기타)
    tab VARCHAR(10) NOT NULL,							 	-- 글의 탭분류 (일반, 질문, 감상, 추천)
    regdate datetime DEFAULT now() NOT NULL,                -- 게시물 작성 날짜
    count INT NOT NULL DEFAULT 0,                           -- 조회수 (기본값 0)
    best VARCHAR(1) NOT NULL DEFAULT "N",				 	-- 인기글여부 (기본값 "N", 인기글활성화 "Y")
    bookid INT,                            				 	-- 북아이디
    ip VARCHAR(45) NOT NULL,                                -- 작성자 IP 주소
    update_date DATETIME,                            		-- 게시물 수정 날짜
    status INT NOT NULL DEFAULT 0                  		 	-- 게시물 상태 (0 : 일반 /  9 : 삭제)
);

-- 추천 테이블 생성
CREATE TABLE likedtbl (
	likedid INT AUTO_INCREMENT PRIMARY KEY,					-- 댓글 ID, 기본키 및 자동 증가
	ref INT NOT NULL, 										-- 좋아요가 속한 게시글 id
	userid INT NOT NULL,									-- 좋아요 누른 유저 id(식별자)
	UNIQUE KEY unique_like (ref, userid)					-- 글id와 유저id 조합이 유일하도록 지정 (무한추천 제한)
);

-- 댓글 테이블 생성
CREATE TABLE commenttbl (
	commentid INT PRIMARY KEY AUTO_INCREMENT,				-- 댓글 ID, 기본키 및 자동 증가
	userid INT NOT NULL, 							        -- 댓글 작성자 id(식별자)
    nickname VARCHAR(100) NOT NULL,							-- 댓글 작성자 닉네임
	content TEXT NOT NULL,									-- 댓글 내용
    ref INT NOT NULL DEFAULT 0,                             -- 댓글이 속한 글 (100~127 사이에서만)
    pos INT NOT NULL DEFAULT 0,								-- 대댓글 순서(위치) - 댓글은 그냥 0이면됨
    depth INT NOT NULL DEFAULT 0,        			        -- 댓글의 깊이 (0은 최상위 댓글)
	parent_commentid INT,									-- 대댓글이 속한 댓글
    regdate DATETIME NOT NULL DEFAULT now(),                -- 댓글 작성 날짜
    update_date DATETIME,                               	-- 댓글 수정 날짜
    ip VARCHAR(45) NOT NULL,                                -- 작성자 IP 주소
    status INT NOT NULL DEFAULT 0							-- 게시물 상태 (0 : 일반 /  9 : 삭제)
);

-- 카테고리 테이블 생성
CREATE TABLE categoryForAdmintbl (
	categoryid INT PRIMARY KEY,								-- 카테고리 ID, 기본키 및 마지막 레코드의 +1
	category VARCHAR(100)									-- 카테고리 이름
);

-- 탭 테이블 생성
CREATE TABLE tabForAdmintbl (
	tabid INT PRIMARY KEY,									-- 탭 ID, 기본키 및 마지막 레코드의  +1
	tab VARCHAR(100)										-- 탭 이름
);




### 필수 데이터 삽입
-- 카테고리 insert 데이터
INSERT INTO categoryForAdmintbl VALUES
(0, "전체"), (1, "문학"), (2, "인문학"), (3, "에세이"), (4, "자기계발"),
(5, "경제경영"), (6, "과학"), (7, "사회과학"), (8, "역사"), (9, "종교"),
(10, "만화"), (11, "기타");

-- 탭 insert 데이터
INSERT INTO tabForAdmintbl VALUES
(0, "전체"), (1, "인기"), (2, "일반"), (3, "질문"), (4, "감상"),
(5, "추천");



## 임시 데이터 삽입
-- 멤버 insert 데이터
INSERT INTO membertbl (userid, account, pwd, question, answer, name, nickname) VALUES
(1, "milky@naver.com", "1234", "아무질문", "대충답", "은하", "밀키"),
(2, "toto@naver.com", "1111", "아무질문", "대충답", "토토", "또또밍기");



### 컨트롤러
# 게시글 테이블
-- 레코드 조회
SELECT * FROM boardtbl;
SELECT * FROM boardtbl WHERE status = 0;
-- 테이블 구조 확인
DESC boardtbl;
-- 레코드 삭제
DELETE FROM boardtbl WHERE boardid > 0;


# 댓글 테이블
-- 레코드 조회
SELECT * FROM commenttbl;
-- 테이블 구조 확인
DESC commenttbl;
-- 레코드 삭제
DELETE FROM commenttbl WHERE commentid > 0;


# 추천 테이블
-- 레코드 조회
SELECT * FROM likedtbl;
-- 테이블 구조 확인
DESC likedtbl;
-- 레코드 삭제
DELETE FROM likedtbl WHERE likedid > 0;


# 카테고리 테이블
-- 레코드 조회
SELECT * FROM categoryForAdmintbl;
-- 테이블 구조확인
DESC categoryForAdmintbl;


# 탭 테이블
-- 레코드 조회
SELECT * FROM tabForAdmintbl;
-- 테이블 구조확인
DESC tabForAdmintbl;


# 멤버 테이블
-- 레코드 조회
SELECT * FROM membertbl;
-- 테이블 구조확인
DESC membertbl;
-- 레코드 삭제
DELETE FROM membertbl WHERE userid > 0;









-- -----------------------------------
### 글목록 추출 쿼리문 (실제 활용 쿼리문 작성시 참고용)
-- 전체글
SELECT * FROM boardtbl WHERE status=0 ORDER BY regdate DESC LIMIT 0, 10;

-- 글 추출 (제목+내용)
SELECT * FROM boardtbl WHERE status=0 AND (title LIKE '%경제%' OR content LIKE '%경제%')
ORDER BY regdate DESC LIMIT 0, 10;

-- 글 추출 (작성자)
SELECT * FROM boardtbl WHERE status=0 AND nickname LIKE '%희%'
ORDER BY regdate DESC LIMIT 0, 10;

-- 글 추출 (카테고리)
SELECT * FROM boardtbl WHERE status=0 AND genre="경제경영"
ORDER BY regdate DESC LIMIT 0, 10;

-- 글 추출 (탭)
SELECT * FROM boardtbl WHERE status=0 AND tab="질문"
ORDER BY regdate DESC LIMIT 0, 10;

-- 인기글 탭 글 추출
SELECT * FROM boardtbl WHERE status=0 AND best='Y' ORDER BY regdate DESC LIMIT 0, 10;

-- 추천수
SELECT * FROM likedtbl;
-- 누적 추천 수 추출
SELECT count(likedid) FROM likedtbl WHERE ref=1;
-- 중복 추천유무 추출
SELECT count(likedid) FROM likedtbl WHERE ref=1 AND userid=1;
-- 추천 insert
INSERT INTO likedtbl (ref, userid) VALUES (1, 1);
-- 추천수에 따른 인기글 부여
UPDATE boardtbl SET best = 'Y' WHERE boardid=1;


### 글상세 추출 쿼리문
# 클릭한 글 추출
INSERT * FROM boardtbl WHERE boardid = 1;



