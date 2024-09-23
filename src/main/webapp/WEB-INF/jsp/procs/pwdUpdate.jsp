<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="procs.ProcsMgr" />
<%
	String newPwd = request.getParameter("newPwd");
	String account = request.getParameter("account");
	String msg="비밀번호 변경에 실패하였습니다";
	
	boolean flag = pMgr.updatePwd(account, newPwd);
	
	if(flag){
		msg="비밀번호 변경에 성공하였습니다";
	}
%>    
<script>
	alert("<%=msg%>");
	location.href="/login/login01";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwdUpdate</title>
</head>
<body>

</body>
</html>