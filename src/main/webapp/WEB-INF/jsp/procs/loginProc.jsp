<%@page import="SHA256.SHASalt"%>
<%@page import="beans.MemberBean"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lMgr" class="login.LoginMgr" />
<%
String account = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String saveId = request.getParameter("saveId");
	
	MemberBean mBean = lMgr.getLoginInfo(account);
	
	int userId = mBean.getUserid();
	String userIdS = Integer.toString(mBean.getUserid());
	
	// SHASALT를 이용하여 해시화된 비밀번호 생성 및 비교
	SHASalt SHASalt = new SHASalt();
	String salt = mBean.getSalt();
	String CrPwd = SHASalt.getEncrypt(pwd, salt);
	if(!CrPwd.equals(mBean.getPwd())){
%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
		<%
	}else{
		session.setAttribute("idKey", userId);
		session.setAttribute("idKeyS", userIdS);
		
		if(saveId != null){
		    Cookie cookie = new Cookie("saveId", account);
		    cookie.setMaxAge(60 * 60 * 24);//쿠키의 보관기간 1일
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