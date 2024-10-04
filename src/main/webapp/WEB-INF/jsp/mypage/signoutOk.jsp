<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="myMgr" class="myPage.MyPageMgr" />
<%
	if (session.getAttribute("idKeyS") == null) {
	    %>
	    <script>
	        alert("세션이 만료되었습니다. 로그인 페이지로 이동합니다.");
	        location.href="/login/login01";
	    </script>
	    <%
	    return;
	}
	String userId = (String) session.getAttribute("idKeyS");
	
	//회원탈퇴/정보제거(회원탈퇴 진행)
	myMgr.signoutMember(userId);
	
	session.invalidate();
%>

<script>
	alert("회원탈퇴가 정상적으로 이루어졌습니다. \n그동안 은하수 책방을 이용해주셔서 감사합니다.");
	location.href = "/";
</script>

	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signoutOk</title>
</head>
<body>

</body>
</html>