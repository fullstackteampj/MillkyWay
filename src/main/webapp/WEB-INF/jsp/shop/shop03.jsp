<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="book.BookInfoMgr" />
<jsp:useBean id="bean" class="beans.ReviewBean" />
<%request.setCharacterEncoding("UTF-8");%>
	
<%
	//한줄평 폼 submit 시 데이터 받기
	bean.setScore(Integer.parseInt(request.getParameter("inputScore")));
	bean.setContent(request.getParameter("content"));
	bean.setUserid(Integer.parseInt(request.getParameter("idKey")));
	bean.setBookid(Integer.parseInt(request.getParameter("bookid")));
	
	//id -> nickname 가져오기
	String nickname = bMgr.getNickname(bean.getUserid());
	bean.setNickname(nickname);
	
	//글 등록
	boolean result = bMgr.insertReview(bean);
	
	String inform = "한줄평 등록에 실패했습니다. 다시 입력해 주세요.";
	
	if(result){
		inform = "한줄평이 등록되었습니다.";
		int newScore =  bMgr.avgScore(bean.getBookid());
		bMgr.updateScore(newScore, bean.getBookid());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한줄평 등록</title>
<style>
	div{
		width: 100%;
		text-align: center;
	}
	div>h1{padding: 20px 0;}
	div>button{
	  background: none;
	  border: none;
	  outline: none;
	  display: block;
	  width: 100px;
	  height: 40px;
	  margin: 80px auto 20px;
	  background-color: #ddd;
	  border-radius: 5px;
	  cursor: pointer;
	}
	div>button:hover{color: darken(#ddd, 2)}
</style>
</head>
<body>
	<div>
		<h1><%=inform%></h1>
		<button type="button" onclick="javascript:closeReload()">닫기</button>
	</div>
<script>
	const closeReload = () => {
		self.close();
		window.opener.location.reload();
	};
</script>
</body>
</html>