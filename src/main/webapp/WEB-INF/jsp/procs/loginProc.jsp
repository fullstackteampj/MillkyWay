<%@page import="beans.MemberBean"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<%
	String account = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String saveId = request.getParameter("saveId");
	
	
	MemberBean mBean = lMgr.getLoginInfo(account);
	String userId = Integer.toString(mBean.getUserid());
	
	if(!pwd.equals(mBean.getPwd())){
		%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
		<%
	}else{
		session.setAttribute("idKey", userId);
		if(saveId != null){
		    Cookie cookie = new Cookie("saveId", account);
		    cookie.setMaxAge(60 * 60 * 24);
		    response.addCookie(cookie);
		}
		%>
		<script>
			alert("로그인에 성공하였습니다.");
			location.href="/";
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginProc</title>
</head>
<body>

</body>
</html>