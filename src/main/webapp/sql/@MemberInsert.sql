

-- ctrl + a (전체선택) 후 ctrl + shift + enter  => 쿼리문 전체 실행

-- 회원 정보를 테이블에 삽입
INSERT INTO membertbl (account, pwd, question, answer, name, nickname, gender, zipcode, address, phone, email, last_login_date, status, favorite, profile_photo) VALUES
('sujin@gmail.com', '1234', '가장 좋아하는 색은 무엇인가요?', '파란색', '수진', '수진이', 'F', '12345', '서울시 123번지', '010-1234-5678', 'sujin@gmail.com', NULL, 'active', '소설, 로맨스', NULL),
('jihye@gmail.com', '1234', '가장 좋아하는 취미는 무엇인가요?', '독서', '지혜', '지혜', 'F', '54321', '부산시 456번지', '010-2345-6789', 'jihye@gmail.com', NULL, 'active', '논픽션, 미스터리', NULL),
('jeonghun@gmail.com', '1234', '가장 좋아하는 영화는 무엇인가요?', '인셉션', '정훈', '정훈이', 'M', '67890', '인천시 789번지', '010-3456-7890', 'jeonghun@gmail.com', NULL, 'active', '과학 소설, 스릴러', NULL),
('millkyway@gmail.com', '1234', '가장 가고 싶은 여행지는 어디인가요?', '파리', '은하수', '밀키웨이', 'M', '13579', '제주시 101번지', '010-4567-8901', 'millkyway@gmail.com', NULL, 'active', '여행, 모험', NULL),
('galaxy@gmail.com', '1234', '가장 좋아하는 책은 무엇인가요?', '1984', '갤럭시', '갤럭시', 'M', '24680', '울산시 202번지', '010-5678-9012', 'galaxy@gmail.com', NULL, 'active', 'SF, 고전', NULL);


UPDATE membertbl SET usergrade="VIP++", curpoint=25000, expectpoint=3000 WHERE userid = 1;
UPDATE membertbl SET usergrade="VIP++", curpoint=45000, expectpoint=15000 WHERE userid = 2;
UPDATE membertbl SET usergrade="VIP++", curpoint=15000, expectpoint=5000 WHERE userid = 3;
UPDATE membertbl SET usergrade="VIP++", curpoint=15000, expectpoint=5000 WHERE userid = 4;
UPDATE membertbl SET usergrade="VIP++", curpoint=15000, expectpoint=5000 WHERE userid = 5;


-- INSERT INTO membertbl (account, pwd, question, answer, name, nickname, gender, zipcode, address, phone, email, last_login_date, status, favorite, profile_photo) VALUES
-- ('galaxy@gmail.com', '1234', '가장 좋아하는 책은 무엇인가요?', '1984', '갤럭시', '갤럭시', 'M', '24680', '울산시 202번지', '010-5678-9012', 'galaxy@gmail.com', curdate(), 'active', 'SF, 고전', NULL);