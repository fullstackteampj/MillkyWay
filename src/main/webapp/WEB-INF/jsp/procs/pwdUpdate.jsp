<%request.setCharacterEncoding("UTF-8");%>
<%@page import="SHA256.SHASalt"%>
<%@page import="beans.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="procs.ProcsMgr" />
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<%
	String newPwd = request.getParameter("newPwd");
	String account = request.getParameter("account");
	String msg="비밀번호 변경에 실패하였습니다";
	
	// shaSalt로 생성된 비밀번호 입력
	MemberBean mBean = lMgr.getLoginInfo(account);
	SHASalt SHASalt = new SHASalt();
	
	String newSalt = SHASalt.genSalt();
	
	String CrPwd = SHASalt.getEncrypt(newPwd, newSalt);
	
	boolean flag = pMgr.updatePwd(account, CrPwd, newSalt);
	
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