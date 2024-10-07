



-- ctrl + a (전체선택) 후 ctrl + shift + enter  => 쿼리문 전체 실행



-- 데이터베이스 테이블 생성 전 초기화
-- 각 테이블간 참조관계를 고려하여 참조된 필드가 있는 테이블 먼저 삭제
-- 모든 테이블이 삭제된 후 데이터베이스를 삭제하여
-- 잔여 데이터가 남지않도록 삭제

DROP TABLE IF EXISTS canceltbl;
DROP TABLE IF EXISTS carttbl;
DROP TABLE IF EXISTS wishtbl;
DROP TABLE IF EXISTS purchasetbl;
DROP TABLE IF EXISTS purchase_bundletbl;
DROP TABLE IF EXISTS commenttbl;
DROP TABLE IF EXISTS Reviewtbl;
DROP TABLE IF EXISTS boardtbl;
DROP TABLE IF EXISTS Booktbl;
DROP TABLE IF EXISTS pointManagementtbl;
DROP TABLE IF EXISTS membertbl;


DROP DATABASE IF EXISTS MillkyWayDB;


-- 데이터베이스 생성 및 사용
CREATE DATABASE MillkyWayDB;
USE MillkyWayDB;


-- 입력당시 날짜 값을 디폴트로 넣고싶을때
-- DATE -> 
-- CREATE TRIGGER before_insert_membertbl
-- BEFORE INSERT ON membertbl
-- FOR EACH ROW
-- SET NEW.signup_date = IFNULL(NEW.signup_date, CURDATE());


-- DATETIME -> DEFAULT now()


-- INSERT문에서는 DATE타입의 필드에 curdate()를 사용하여 데이터 생성시의 날짜 입력 가능

-- @파일 실행순서
-- @BookInsert -> @BookUpdate -> @MemberInsert -> @BoardInsert -> @ReviewInsert -> @ElseInsert
-- 파일실행순서의 이유는 각 테이블에서 참조하고있는 값(userID, bookID)가 존재하지 않으면
-- 그 값을 참조하는 테이블도 값이 들어가지 않기때문
-- 추가로 인서트 후에 업데이트문을 실행하여 생성되지 않은 테이블에 업데이트 명령을 내리지 않도록 실행



-- 회원 정보를 저장하는 테이블
CREATE TABLE membertbl (
    userid INT PRIMARY KEY AUTO_INCREMENT,  -- 회원 ID, 기본 키 및 자동 증가
    account VARCHAR(100) NOT NULL unique,   -- 회원 계정 (이메일 또는 사용자 이름)
    pwd VARCHAR(100) NULL,              	-- 비밀번호
    salt VARCHAR(100) NULL,             	-- salt값
    question VARCHAR(100) NULL,         	-- 질문
    answer VARCHAR(100) NULL,           	-- 답
    name VARCHAR(100) NOT NULL,             -- 회원 이름
    nickname VARCHAR(100),                  -- 별명
    gender CHAR(1) default null,            -- 성별 (M, F)
    zipcode VARCHAR(10) default 00000,      -- 우편번호
    usergrade VARCHAR(100) default 'vip',	-- 유저등급
	  curpoint int default 0,				 	-- 보유포인트 //디폴트값 추가 
	  expectpoint int default 0,				-- 적립예정포인트
    address TEXT,        					-- 주소
	  detailAddress TEXT,                     -- 상세 주소  // 추가한 컬럼
    phone VARCHAR(20),                      -- 전화번호
    email VARCHAR(100) default null,        -- 이메일
    signup_date DATE,     					-- 회원 가입 날짜, 기본값 현재 날짜
    last_login_date DATE,                   -- 마지막 로그인 날짜
    status VARCHAR(20),                     -- 회원 상태 (active, inactive 등)
    favorite TEXT default null,             -- 좋아하는 장르 배열로 입력 (확인 필요)
    profile_photo BLOB,                     -- 프로필 사진
    birth VARCHAR(20) default null,			-- 생년월일
    agree CHAR(1)                           -- 선택 사항 동의여부
);

-- 트리거는 날짜 기본값 설정에 불필요함


CREATE TRIGGER before_insert_membertbl
BEFORE INSERT ON membertbl
FOR EACH ROW
SET NEW.signup_date = IFNULL(NEW.signup_date, CURDATE());


-- 포인트 관리 테이블
CREATE TABLE pointManagementtbl (
	pointid INT PRIMARY KEY AUTO_INCREMENT,
	userid INT,  
    point INT, 
    division VARCHAR(5), 		-- 구분(적립/차감)
    update_date DATETIME,  
    FOREIGN KEY (userid) REFERENCES membertbl(userid)
);


-- 도서 정보를 저장하는 테이블
CREATE TABLE Booktbl (
    bookid INT PRIMARY KEY AUTO_INCREMENT,          -- 도서 ID, 기본 키 및 자동 증가
    author VARCHAR(100),                            -- 저자 이름
    category VARCHAR(50),                           -- 도서 카테고리 (국내도서, 해외도서 등)
    genre VARCHAR(50),                              -- 도서 장르 (소설, 역사, 철학 등)
    title VARCHAR(200),                             -- 도서 제목
    review TEXT,                                    -- 도서 리뷰
    score INT,                                      -- 도서 평점 (1~5 사이의 정수)
    contents TEXT,                                  -- 도서 내용 요약
    authorIntro TEXT,                               -- 저자소개
    contentsTables TEXT,						    -- 목차
    miniIntro TEXT,                                 -- 간단한 설명
    photo MEDIUMBLOB,                                     -- 도서 표지 사진
    publish_date DATE,                              -- 출판일
    isbn VARCHAR(20),                               -- ISBN (국제 표준 도서 번호)
    stock_Quantity INT,                              -- 재고 수량
    price INT,                                       -- 도서 가격 (원화)
    pages INT 										-- 도서 페이지수 
);


-- 게시판 게시물을 저장하는 테이블
/*
CREATE TABLE boardtbl (
    boardid INT PRIMARY KEY AUTO_INCREMENT,         -- 게시물 ID, 기본 키 및 자동 증가
    title VARCHAR(200),                             -- 게시물 제목
    author VARCHAR(100),                            -- 작성자 이름
    genre VARCHAR(50),                              -- 도서 장르 (소설, 역사, 철학 등)
    tab VARCHAR(10),								-- 글의 탭분류 (인기, 일반, 질문, 감상)
    content TEXT,                                   -- 게시물 내용
    count INT DEFAULT 0,                            -- 조회수 (기본값 0)
    regdate datetime default now(),                 -- 게시물 작성 날짜
    photo BLOB,                                     -- 게시물에 포함된 사진

    -- 보드테이블 인서트문제떄문에 임시로 살려놓음(ref,pos,depth)
    ref INT DEFAULT 0,                              -- 댓글이 속한 댓글위치(0은 최상위 댓글)
    pos INT DEFAULT 0,        			        -- 댓글의 깊이 (0은 최상위 댓글)
    depth INT DEFAULT 0,        			        -- 댓글의 깊이 (0은 최상위 댓글)


    userid INT,                            		    -- 작성자 ID, 외래 키로 `membertbl` 참조
    bookid INT,                             		-- 북아이디

    liked INT DEFAULT 0,                            -- 좋아요 갯수
    
    ip VARCHAR(45),                                 -- 작성자 IP 주소
    update_date DATE,                               -- 게시물 수정 날짜
    comment_count INT DEFAULT 0,                    -- 댓글 수 (기본값 0)
    status VARCHAR(20),                             -- 게시물 상태 (active, inactive 등)

    FOREIGN KEY (userid) REFERENCES membertbl(userid),  -- 작성자 ID와 외래 키 연결
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)
); */

-- 게시글 테이블 생성
CREATE TABLE boardtbl (
    boardid INT PRIMARY KEY AUTO_INCREMENT,					-- 게시물 ID, 기본 키 및 자동 증가
    userid INT NOT NULL,                            		-- 작성자 ID(식별자)
    nickname VARCHAR(100) NOT NULL,                         -- 작성자 닉네임
    title VARCHAR(200) NOT NULL,                            -- 게시물 제목
    content TEXT NOT NULL,                                  -- 게시물 내용
    photo MEDIUMBLOB,                               	 	-- 게시물에 포함된 사진
    photo_name VARCHAR(100),                        		-- 사진 이름
    genre VARCHAR(50) NOT NULL,                             -- 도서 장르 (문학, 인문학, 에세이, 자기계발, 경제경영, 과학, 사회과학, 역사, 종교, 만화, 기타)
    tab VARCHAR(10) NOT NULL DEFAULT '일반',					-- 글의 탭분류 (일반, 질문, 감상, 추천)
    regdate datetime DEFAULT now() NOT NULL,                -- 게시물 작성 날짜
    count INT NOT NULL DEFAULT 0,                           -- 조회수 (기본값 0)
    best VARCHAR(1) NOT NULL DEFAULT "N",				 	-- 인기글여부 (기본값 "N", 인기글활성화 "Y")
    bookid INT,                            				 	-- 북아이디
    ip VARCHAR(45) NOT NULL,                                -- 작성자 IP 주소
    update_date DATETIME,                            		-- 게시물 수정 날짜
    status INT NOT NULL DEFAULT 0                 		 	-- 게시물 상태 (0 : 일반 /  9 : 삭제)
);

-- 댓글 테이블 생성
CREATE TABLE commenttbl (
   commentid INT PRIMARY KEY AUTO_INCREMENT,            	-- 댓글 ID, 기본키 및 자동 증가
   userid INT NOT NULL,                              		-- 댓글 작성자 id(식별자)
    nickname VARCHAR(100) NOT NULL,                     	-- 댓글 작성자 닉네임
   content TEXT NOT NULL,                           		-- 댓글 내용
    boardid INT NOT NULL DEFAULT 0,                     	-- 댓글이 속한 글
    pos INT NOT NULL DEFAULT 0,                        		-- 대댓글 순서(위치)
    depth INT NOT NULL DEFAULT 0,                       	-- 댓글의 깊이 (0은 최상위 댓글)
   	ref INT,                                    			-- 대댓글이 속한 조상댓글
   	parentid INT,                                 			-- 대댓글이 속한 직계부모댓글
    regdate DATETIME NOT NULL DEFAULT now(),            	-- 댓글 작성 날짜
    update_date DATETIME,                               	-- 댓글 수정 날짜
    delete_date DATETIME,                               	-- 댓글 삭제 날짜
    ip VARCHAR(45) NOT NULL,                            	-- 작성자 IP 주소
    status INT NOT NULL DEFAULT 0,                     		-- 게시물 상태 (0 : 일반 /  9 : 삭제)
    totalChild INT DEFAULT 0                        		-- 조상댓글의 자손댓글 수
);

-- 추천 테이블 생성
CREATE TABLE likedtbl (
	likedid INT AUTO_INCREMENT PRIMARY KEY,					-- 댓글 ID, 기본키 및 자동 증가
	ref INT NOT NULL, 										-- 좋아요가 속한 게시글 id
	userid INT NOT NULL,									-- 좋아요 누른 유저 id(식별자)
	UNIQUE KEY unique_like (ref, userid)					-- 글id와 유저id 조합이 유일하도록 지정 (무한추천 제한)
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



-- 리뷰테이블을 만듭시다(책마다 별도관리)
CREATE TABLE Reviewtbl (
	reviewid INT PRIMARY KEY AUTO_INCREMENT,
	userid INT,  
    bookid INT, 
    score INT, 
    nickname VARCHAR(50), 
    content TEXT, 
    FOREIGN KEY (userid) REFERENCES membertbl(userid),
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)
);

CREATE TABLE purchasetbl (
    purchaseid INT PRIMARY KEY AUTO_INCREMENT,      -- 자동 증가하는 구매 ID
    userid INT,                                     -- 사용자 ID
    bookid INT,                                     -- 구매한 도서 ID, 외래 키로 Booktbl 참조
    bundleid INT default null,                      -- 묶음 ID, NULL이면 단독 구매
    status VARCHAR(20) default'대기중',               -- 구매 상태
    purchase_date DATE,                             -- 구매 날짜
    quantity INT,                                   -- 구매 수량
    pay_method VARCHAR(10),                         -- 결제 수단 
    FOREIGN KEY (userid) REFERENCES membertbl(userid),  -- 구매자 ID와 외래 키 연결
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)     -- 도서 ID와 외래 키 연결
);

-- 구매묶음 관리 테이블
CREATE TABLE purchase_bundle (
    bundleid INT PRIMARY KEY AUTO_INCREMENT,   -- 묶음 ID
    userid INT,                                -- 사용자 ID
    purchase_date DATE ,                        -- 묶음 구매 날짜
    total_price INT                    		-- 총 결제 금액
);

-- 관심목록 항목을 저장하는 테이블
CREATE TABLE wishtbl (
	wishid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,                             -- 사용자 ID, 외래 키로 `membertbl` 참조
    bookid INT,                                     -- 도서 ID, 외래 키로 `Booktbl` 참조
    status VARCHAR(20) default'active',             -- 위시리스트 상태 (active, inactive 등)
    added_date DATE,                                -- 위시리스트 추가 날짜

    FOREIGN KEY (userid) REFERENCES membertbl(userid),  -- 사용자 ID와 외래 키 연결
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)     -- 도서 ID와 외래 키 연결
);

-- 장바구니 항목을 저장하는 테이블
CREATE TABLE carttbl (
	cartid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,                             -- 사용자 ID, 외래 키로 `membertbl` 참조
    bookid INT,                                     -- 도서 ID, 외래 키로 `Booktbl` 참조
    status VARCHAR(20) default'active',             -- 장바구니 상태 (active, inactive 등)
    added_date DATE,                                -- 장바구니 추가 날짜
    quantity INT default 1,                         -- 장바구니에 담긴 수량

    FOREIGN KEY (userid) REFERENCES membertbl(userid),  -- 사용자 ID와 외래 키 연결
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)     -- 도서 ID와 외래 키 연결
);

-- 주문 취소 내역을 저장하는 테이블
CREATE TABLE canceltbl (
	cancelid INT PRIMARY KEY AUTO_INCREMENT,
    userid INT,                             -- 사용자 ID, 외래 키로 `membertbl` 참조
    bookid INT,                                     -- 도서 ID, 외래 키로 `Booktbl` 참조
    status VARCHAR(20),                             -- 주문 취소 상태 (cancelled, pending 등)
    price INT default 12000,
    quantity INT default 1,
    cancellation_date DATE,                         -- 주문 취소 날짜
    cancellation_reason TEXT,                       -- 주문 취소 사유

    FOREIGN KEY (userid) REFERENCES membertbl(userid),  -- 사용자 ID와 외래 키 연결
    FOREIGN KEY (bookid) REFERENCES Booktbl(bookid)     -- 도서 ID와 외래 키 연결
);

