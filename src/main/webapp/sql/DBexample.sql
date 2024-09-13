-- 다중 구조 작성 예시(댓글,대댓글,대대댓글)
-- 게시물(boardid = 1)에 최상위 댓글을 작성:
INSERT INTO commenttbl (boardid, parent_commentid, userid, content, regdate, status, depth)
VALUES (1, NULL, 'user01', '이 책 정말 재미있었어요!', NOW(), 'active', 0);

-- 이 댓글에 대댓글(depth = 1)을 작성
INSERT INTO commenttbl (boardid, parent_commentid, userid, content, regdate, status, depth)
VALUES (1, 1, 'user02', '저도 동의해요!', NOW(), 'active', 1);

-- 대댓글에 또 대댓글(depth = 2)을 작성:
INSERT INTO commenttbl (boardid, parent_commentid, userid, content, regdate, status, depth)
VALUES (1, 2, 'user03', '하지만 저는 다른 생각이 있어요.', NOW(), 'active', 2);



-- 댓글 트리 조회 예시
SELECT * FROM commenttbl 
WHERE boardid = 1
ORDER BY regdate ASC, depth ASC;




-- boardtbl의 author 필드에 별명 연동
INSERT INTO boardtbl (title, author, content, userid, ip, regdate, status)
SELECT 
    '게시글 제목', 
    membertbl.nickname,  -- membertbl의 nickname을 author 필드에 저장
    '게시글 내용', 
    membertbl.userid, 
    '127.0.0.1', 
    CURDATE(), 
    'active'
FROM 
    membertbl
WHERE 
    membertbl.userid = 1;  -- 작성자의 userid




-- 트리거를 사용한 DB자체 댓글숫자 관리 예시(데이터베이스에 오버헤드 문제발생 가능)
-- JAVA(JSP) 단에서 쿼리문 작성을 통한 관리도 가능
-- JSP단에서 관리한다면 WAS 와 DB간 통신이 많아져서 어플리케이션에 과부하가걸리는 가능성도 존재함

DELIMITER // -- 구분자 변경

CREATE TRIGGER after_comment_insert
AFTER INSERT ON commenttbl
FOR EACH ROW
BEGIN
    UPDATE boardtbl
    SET comment_count = comment_count + 1
    WHERE boardid = NEW.boardid;
END//

DELIMITER ; -- 구분자 원복


DELIMITER // -- 구분자 변경

CREATE TRIGGER after_comment_delete
AFTER DELETE ON commenttbl
FOR EACH ROW
BEGIN
    UPDATE boardtbl
    SET comment_count = comment_count - 1
    WHERE boardid = OLD.boardid;
END//

DELIMITER ; -- 구분자 원복
