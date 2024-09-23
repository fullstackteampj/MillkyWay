<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="beans.MemberBean" %>
<%
	//임시로 로그인 세션 저장
	MemberBean mBean = new MemberBean();
	mBean.setUserid(2);
	mBean.setAccount("toto@naver.com");
	mBean.setNickname("또또밍기");
	session.setAttribute("mBean", mBean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("또또밍기 로그인\n비번 1111");
	location.href="../board01";
</script>
</head>
<body>
</body>
</html>