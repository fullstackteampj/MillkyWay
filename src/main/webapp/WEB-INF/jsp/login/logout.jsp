<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script>
	if (confirm("로그아웃 하시겠습니까?")) {
		<%
		session.invalidate();
		%>
		alert("로그아웃되었습니다."); // 로그아웃 완료 메시지
	}
	location.href="/login/login01";
</script>
</body>
</html>